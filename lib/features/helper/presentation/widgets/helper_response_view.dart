import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sheshield/features/helper/presentation/helper_colors.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/chat/presentation/sos_chat_screen.dart';
import 'package:sheshield/features/helper/domain/entities/accepted_alert.dart';
import 'package:sheshield/features/helper/domain/entities/helper_models.dart';
import 'package:sheshield/features/helper/domain/repositories/i_helper_repository.dart';
import 'package:sheshield/features/helper/domain/usecases/release_alert_usecase.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_extras_provider.dart';
import 'package:sheshield/features/report/presentation/widgets/report_user_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

/// Everything a helper needs once they hold an alert: live map, safety
/// banners, stage tracking (En route -> Arrived -> Assisting), navigation,
/// 999, in-app chat, phone, "mark resolved", back out and report.
///
/// Polls GET /helper/alerts/{id}/live. The server is the authority: when the
/// requester resolves, or the lock is lost, [onEnded] fires and access is
/// already revoked server-side (the live call stops returning coordinates).
class HelperResponseView extends ConsumerStatefulWidget {
  const HelperResponseView({
    super.key,
    required this.alert,
    this.initialStage = ResponseStage.none,
    required this.onEnded,
  });

  final AcceptedAlert alert;
  final ResponseStage initialStage;

  /// Called once when the response is over (resolved / released / revoked).
  final VoidCallback onEnded;

  @override
  ConsumerState<HelperResponseView> createState() => _HelperResponseViewState();
}

class _HelperResponseViewState extends ConsumerState<HelperResponseView> {
  final _repo = getIt<IHelperRepository>();
  Timer? _timer;
  LiveState? _live;
  late ResponseStage _stage = widget.initialStage;
  bool _busy = false;
  bool _ended = false;

  @override
  void initState() {
    super.initState();
    _poll();
    _timer = Timer.periodic(Duration(seconds: 5), (_) => _poll());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _end() {
    if (_ended) return;
    _ended = true;
    _timer?.cancel();
    ref.invalidate(myResponseProvider);
    ref.invalidate(helperStatsProvider);
    ref.invalidate(helperHistoryProvider);
    widget.onEnded();
  }

  Future<void> _poll() async {
    try {
      final live = await _repo.fetchLive(widget.alert.id);
      if (!mounted) return;
      setState(() {
        _live = live;
        if (live.stage.index > _stage.index) _stage = live.stage;
      });
      if (!live.isOpen) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(live.endedByRequester ? 'The person marked themselves safe. Thank you for responding.' : 'This alert is no longer assigned to you.'),
          ));
        }
        _end();
      }
    } on HelperFailure catch (e) {
      // 403/409 means the lock is gone; any other failure is just a missed poll.
      if (e.message.contains('currently hold')) _end();
    } catch (_) {}
  }

  void _toast(String m) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

  Future<void> _setStage(ResponseStage next) async {
    if (next.index <= _stage.index || _busy) return;
    setState(() => _busy = true);
    try {
      await _repo.setProgress(widget.alert.id, next);
      if (mounted) setState(() => _stage = next);
    } on HelperFailure catch (e) {
      if (mounted) _toast(e.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _resolve() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Mark as resolved?'),
        content: Text('This closes the alert and ends your access to the person\'s location and chat. Only do this once they are safe.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text('Not yet')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text('Resolved')),
        ],
      ),
    );
    if (ok != true) return;
    setState(() => _busy = true);
    try {
      await _repo.resolve(widget.alert.id);
      if (mounted) _toast('Alert resolved. Thank you for helping.');
      _end();
    } on HelperFailure catch (e) {
      if (mounted) {
        setState(() => _busy = false);
        _toast(e.message);
      }
    }
  }

  Future<void> _release() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Can't help with this?"),
        content: Text('This hands the alert back to other nearby helpers. Only do this if the situation seems unsafe, suspicious, or you truly can\'t respond.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text('Stay on it')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text('Back out')),
        ],
      ),
    );
    if (confirmed != true) return;
    setState(() => _busy = true);
    try {
      await getIt<ReleaseAlertUseCase>().call(widget.alert.id);
      _end();
    } catch (_) {
      if (mounted) {
        setState(() => _busy = false);
        _toast('Could not back out. Please try again.');
      }
    }
  }

  LatLng get _point {
    final lat = _live?.latitude ?? widget.alert.latitude;
    final lng = _live?.longitude ?? widget.alert.longitude;
    return LatLng(lat, lng);
  }

  Future<void> _navigate() => launchUrl(
        Uri.parse('https://www.google.com/maps/dir/?api=1&destination=${_point.latitude},${_point.longitude}'),
        mode: LaunchMode.externalApplication,
      );

  Future<void> _call(String number) async {
    final ok = await launchUrl(Uri(scheme: 'tel', path: number.replaceAll(' ', '')));
    if (!ok && mounted) _toast("Couldn't open the dialer.");
  }

  @override
  Widget build(BuildContext context) {
    final alert = widget.alert;
    final live = _live;
    final point = _point;

    Widget banner(IconData icon, String text, Color color) => Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color.withValues(alpha: 0.35)),
          ),
          child: Row(children: [
            Icon(icon, color: color, size: 20),
            SizedBox(width: 10),
            Expanded(child: Text(text, style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 12.5, height: 1.3))),
          ]),
        );

    return ListView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 110),
      children: [
        if (live?.duressActive == true)
          banner(Icons.warning_amber_rounded, 'A duress signal was triggered on this SOS. Treat this as an active emergency and call 999 if you can\'t reach them.', AppTheme.accentRed),
        if (live?.connectivityLost == true)
          banner(Icons.signal_cellular_connected_no_internet_0_bar_rounded, "This person's location hasn't updated in a while. Their connection may be lost.", Colors.orange.shade800),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(color: context.hp.surface, borderRadius: BorderRadius.circular(18)),
          child: Row(children: [
            CircleAvatar(backgroundColor: context.hp.primary, child: Text(alert.userName.isEmpty ? '?' : alert.userName[0].toUpperCase(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800))),
            SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(alert.userName, style: TextStyle(color: context.hp.textPrimary, fontWeight: FontWeight.w800, fontSize: 16)),
                Text('Accepted ${_ago(alert.acceptedAt)}', style: TextStyle(color: context.hp.textSecondary, fontSize: 12)),
              ]),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: Color(0xFF3B82F6).withValues(alpha: 0.18), borderRadius: BorderRadius.circular(8)),
              child: Text(_stage.label, style: TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.w800, fontSize: 12)),
            ),
          ]),
        ),
        SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: SizedBox(
            height: 220,
            child: Stack(children: [
              FlutterMap(
                key: ValueKey('${point.latitude.toStringAsFixed(4)},${point.longitude.toStringAsFixed(4)}'),
                options: MapOptions(
                  initialCenter: point,
                  initialZoom: 15,
                  interactionOptions: InteractionOptions(flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag),
                ),
                children: [
                  TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', userAgentPackageName: 'com.sheshield.app'),
                  MarkerLayer(markers: [Marker(point: point, width: 40, height: 40, child: Icon(Icons.location_on, color: AppTheme.accentRed, size: 40))]),
                  RichAttributionWidget(
                    alignment: AttributionAlignment.bottomLeft,
                    showFlutterMapAttribution: false,
                    attributions: [TextSourceAttribution('OpenStreetMap contributors', onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')))],
                  ),
                ],
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: context.hp.surface.withValues(alpha: 0.92), borderRadius: BorderRadius.circular(8)),
                  child: Text(live == null ? 'Location at acceptance' : 'Live${live.updatedAt == null ? '' : ' - ${_ago(live.updatedAt!)}'}',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: context.hp.textSecondary)),
                ),
              ),
            ]),
          ),
        ),
        SizedBox(height: 12),
        Row(children: [
          Expanded(child: _Action(icon: Icons.navigation_rounded, label: 'Navigate', color: Color(0xFF2563EB), onTap: _navigate)),
          SizedBox(width: 10),
          Expanded(child: _Action(icon: Icons.call_rounded, label: 'Call 999', color: Color(0xFF16A34A), onTap: () => _call('999'))),
          SizedBox(width: 10),
          Expanded(
            child: _Action(
              icon: Icons.chat_bubble_rounded,
              label: 'Chat',
              color: context.hp.primary,
              onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => SosChatScreen(sosId: alert.id, iAmHelper: true))),
            ),
          ),
        ]),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(color: Color(0xFFEA580C).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(16)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [Icon(Icons.warning_amber_rounded, color: Color(0xFFC2410C), size: 18), SizedBox(width: 6), Text('Safety reminders', style: TextStyle(color: context.hp.textPrimary, fontWeight: FontWeight.w800))]),
            SizedBox(height: 6),
            Text('- Keep talking to the person through the in-app chat\n- Don\'t put yourself in danger\n- Call 999 if the situation escalates\n- Stay in well-lit, public areas when possible',
                style: TextStyle(color: context.hp.textSecondary, fontSize: 12.5, height: 1.5)),
          ]),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(color: context.hp.surface, borderRadius: BorderRadius.circular(16)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Update response status', style: TextStyle(color: context.hp.textPrimary, fontWeight: FontWeight.w800)),
            SizedBox(height: 10),
            for (final s in const [ResponseStage.enRoute, ResponseStage.arrived, ResponseStage.assisting])
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: (_busy || s.index <= _stage.index) ? null : () => _setStage(s),
                    icon: Icon(s.index <= _stage.index ? Icons.check_circle_rounded : switch (s) {
                      ResponseStage.enRoute => Icons.navigation_rounded,
                      ResponseStage.arrived => Icons.place_rounded,
                      _ => Icons.shield_rounded,
                    }),
                    label: Text(switch (s) {
                      ResponseStage.enRoute => 'En route to location',
                      ResponseStage.arrived => 'Arrived at location',
                      _ => 'Currently assisting',
                    }),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: s.index <= _stage.index ? Color(0xFF16A34A) : context.hp.textPrimary,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    ),
                  ),
                ),
              ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: (_busy || _stage.index < ResponseStage.arrived.index) ? null : _resolve,
                icon: Icon(Icons.verified_rounded),
                label: Text(_stage.index < ResponseStage.arrived.index ? 'Mark as resolved (after you arrive)' : 'Mark as resolved'),
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF16A34A), foregroundColor: Colors.white, padding: EdgeInsets.symmetric(vertical: 16)),
              ),
            ),
          ]),
        ),
        SizedBox(height: 8),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextButton.icon(
            onPressed: _busy ? null : _release,
            icon: Icon(Icons.undo_rounded, size: 18),
            label: Text("Can't help - back out"),
            style: TextButton.styleFrom(foregroundColor: AppTheme.accentRed),
          ),
          TextButton.icon(
            onPressed: () => showReportUserSheet(context, reportedId: alert.requesterUid, reporterRole: 'helper', sosId: alert.id),
            icon: Icon(Icons.flag_outlined, size: 18),
            label: Text('Report'),
            style: TextButton.styleFrom(foregroundColor: context.hp.textSecondary),
          ),
        ]),
      ],
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({required this.icon, required this.label, required this.color, required this.onTap});
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 22), SizedBox(height: 4), Text(label, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700))]),
      );
}

String _ago(DateTime from) {
  final d = DateTime.now().difference(from);
  if (d.inSeconds < 60) return 'just now';
  if (d.inMinutes < 60) return '${d.inMinutes} min ago';
  if (d.inHours < 24) return '${d.inHours} h ago';
  return '${d.inDays} d ago';
}