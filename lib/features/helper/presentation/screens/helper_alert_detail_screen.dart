import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/helper/domain/entities/accepted_alert.dart';
import 'package:sheshield/features/helper/domain/entities/safety_status.dart';
import 'package:sheshield/features/helper/domain/usecases/get_safety_status_usecase.dart';
import 'package:sheshield/features/helper/domain/usecases/release_alert_usecase.dart';
import 'package:sheshield/features/report/presentation/widgets/report_user_sheet.dart';

/// Shown only after AcceptAlertUseCase succeeds -- the one screen in
/// helper mode that ever displays an exact location or phone number,
/// and only to the single helper who won the accept race.
class HelperAlertDetailScreen extends StatefulWidget {
  const HelperAlertDetailScreen({super.key, required this.alert});
  final AcceptedAlert alert;

  @override
  State<HelperAlertDetailScreen> createState() => _HelperAlertDetailScreenState();
}

class _HelperAlertDetailScreenState extends State<HelperAlertDetailScreen> {
  bool _releasing = false;
  SafetyStatus? _safetyStatus;
  Timer? _safetyPollTimer;

  @override
  void initState() {
    super.initState();
    _pollSafetyStatus();
    _safetyPollTimer = Timer.periodic(const Duration(seconds: 15), (_) => _pollSafetyStatus());
  }

  @override
  void dispose() {
    _safetyPollTimer?.cancel();
    super.dispose();
  }

  Future<void> _pollSafetyStatus() async {
    try {
      final status = await getIt<GetSafetyStatusUseCase>().call(widget.alert.id);
      if (mounted) setState(() => _safetyStatus = status);
    } catch (_) {
      // Best-effort: a failed poll just means the banner doesn't update
      // this cycle, never something to interrupt the helper over.
    }
  }

  Future<void> _openMaps() async {
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${widget.alert.latitude},${widget.alert.longitude}',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _call(BuildContext context) async {
    final uri = Uri(scheme: 'tel', path: widget.alert.fullPhone.replaceAll(' ', ''));
    final opened = await launchUrl(uri);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Couldn't open the dialer.")));
    }
  }

  /// "Reviews the live feed... can decline/back out if the situation
  /// seems unsafe or suspicious" -- spec §2. Reopens the alert for the
  /// standby helpers and leaves this screen.
  Future<void> _release() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Can't help with this?"),
        content: const Text(
          "This will hand the alert back to other nearby helpers. Only do this if the situation seems "
          "unsafe, suspicious, or you truly can't respond.",
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Stay on it')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Back out')),
        ],
      ),
    );
    if (confirmed != true) return;

    setState(() => _releasing = true);
    try {
      await getIt<ReleaseAlertUseCase>().call(widget.alert.id);
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      if (mounted) {
        setState(() => _releasing = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Could not back out. Please try again.')));
      }
    }
  }

  Future<void> _report() async {
    await showReportUserSheet(
      context,
      reportedId: widget.alert.requesterUid,
      reporterRole: 'helper',
      sosId: widget.alert.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final alert = widget.alert;
    return Scaffold(
      appBar: AppBar(title: const Text('Respond now')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.accentRed.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.emergency_share_rounded, color: AppTheme.accentRed),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '${alert.userName} needs help. You accepted this alert -- get there safely.',
                        style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black87, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
              if (_safetyStatus?.duressActive == true) ...[
                const SizedBox(height: 12),
                _SafetyBanner(
                  icon: Icons.warning_amber_rounded,
                  text: 'A duress signal was triggered on this SOS. Treat this as an active emergency.',
                  color: AppTheme.accentRed,
                ),
              ],
              if (_safetyStatus?.connectivityLost == true) ...[
                const SizedBox(height: 12),
                _SafetyBanner(
                  icon: Icons.signal_cellular_connected_no_internet_0_bar_rounded,
                  text: "This person's location hasn't updated in a while -- their connection may be lost.",
                  color: Colors.orange.shade800,
                ),
              ],
              const SizedBox(height: 24),
              const Text('Contact', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Colors.black54)),
              const SizedBox(height: 6),
              Text(alert.fullPhone, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: Colors.black87)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _openMaps,
                      icon: const Icon(Icons.directions_rounded),
                      label: const Text('Open route'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentEmerald,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _call(context),
                      icon: const Icon(Icons.call_rounded),
                      label: const Text('Call'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.accentEmerald,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: _releasing ? null : _release,
                  icon: _releasing
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.undo_rounded, size: 18),
                  label: Text(_releasing ? 'Backing out...' : "Can't help -- back out"),
                  style: TextButton.styleFrom(foregroundColor: AppTheme.accentRed),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: _report,
                  icon: const Icon(Icons.flag_outlined, size: 18),
                  label: const Text('Report this person'),
                  style: TextButton.styleFrom(foregroundColor: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SafetyBanner extends StatelessWidget {
  const _SafetyBanner({required this.icon, required this.text, required this.color});

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: color, fontWeight: FontWeight.w700, fontSize: 12.5, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}
