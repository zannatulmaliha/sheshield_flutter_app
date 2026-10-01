import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sheshield/features/helper/presentation/helper_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/features/helper/domain/entities/helper_models.dart';
import 'package:sheshield/features/helper/domain/entities/nearby_alert.dart';
import '../providers/helper_extras_provider.dart';
import '../providers/helper_status_provider.dart';
import '../providers/nearby_alerts_provider.dart';
import '../widgets/active_helper_card.dart';
import '../widgets/helper_not_verified_view.dart';
import '../widgets/inactive_helper_hint.dart';
import '../widgets/nearby_alert_card.dart';

/// GO ACTIVE toggle, response radius, and the nearby-alerts list.
/// [isVerified]/[onVerify] gate the whole screen -- an unverified
/// helper never sees the toggle or any alert data.
class HelperDashboardScreen extends ConsumerStatefulWidget {
  const HelperDashboardScreen({
    super.key,
    required this.isVerified,
    required this.onVerify,
  });

  final bool isVerified;
  final VoidCallback onVerify;

  @override
  ConsumerState<HelperDashboardScreen> createState() => _HelperDashboardScreenState();
}

class _HelperDashboardScreenState extends ConsumerState<HelperDashboardScreen> {
  Timer? _pollTimer;

  @override
  void initState() {
    super.initState();
    if (widget.isVerified) {
      _pollTimer = Timer.periodic(
        Duration(seconds: 15),
        (_) => ref.read(nearbyAlertsControllerProvider.notifier).refresh(),
      );
    }
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  Future<void> _onToggle(bool value) async {
    final error = await ref.read(helperStatusControllerProvider.notifier).toggleActive(value);
    if (error != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    }
  }

  Future<void> _onAccept(NearbyAlert alert) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Accept this alert?'),
        content: Text(
          'You will get the exact location and phone number for the '
          'person ${alert.distanceLabel}, near ${alert.roughArea}.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text('Accept')),
        ],
      ),
    );
    if (confirmed != true) return;

    final accepted = await ref.read(nearbyAlertsControllerProvider.notifier).accept(alert.id);
    if (!mounted) return;

    if (accepted != null) {
      ref.invalidate(myResponseProvider);
      await HelperAlertDetailRoute($extra: accepted).push(context);
      ref.invalidate(helperStatsProvider);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Someone else already responded to this alert.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVerified) {
      return HelperNotVerifiedView(onVerify: widget.onVerify);
    }

    final statusAsync = ref.watch(helperStatusControllerProvider);
    final alertsAsync = ref.watch(nearbyAlertsControllerProvider);

    return statusAsync.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
      data: (status) => SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () => ref.read(nearbyAlertsControllerProvider.notifier).refresh(),
          child: ListView(
            padding: EdgeInsets.fromLTRB(20, 12, 20, 140),
            children: [
              Text(
                AppLocalizations.of(context)!.helperDashboard,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 20),
              ActiveHelperCard(
                status: status,
                isBusy: statusAsync.isLoading,
                onToggle: _onToggle,
                onRadiusChanged: (km) =>
                    ref.read(helperStatusControllerProvider.notifier).setRadius(km),
                onMutualConnectionChanged: (value) => ref
                    .read(helperStatusControllerProvider.notifier)
                    .setMutualConnectionOptIn(value),
              ),
              SizedBox(height: 16),
              _StatsRow(stats: ref.watch(helperStatsProvider).valueOrNull ?? HelperStats()),
              SizedBox(height: 22),
              if (status.isActive)
                ..._alertsSection(alertsAsync)
              else
                InactiveHelperHint(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _alertsSection(AsyncValue<List<NearbyAlert>> alertsAsync) {
    final alerts = alertsAsync.valueOrNull ?? <NearbyAlert>[];
    return [
      // ICU plural message -- the count drives which of the =0/=1/other
      // branches renders (and, for locales with richer plural rules
      // than English, e.g. some Arabic/Slavic forms, intl handles
      // those extra branches too if added to the .arb entry).
      Text(
        AppLocalizations.of(context)!.nearbyAlertsCount(alerts.length),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
      ),
      SizedBox(height: 12),
      if (alertsAsync.isLoading && alerts.isEmpty)
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Center(child: CircularProgressIndicator()),
        )
      else
        for (final alert in alerts)
          Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: NearbyAlertCard(alert: alert, isBusy: false, onAccept: () => _onAccept(alert)),
          ),
    ];
  }
}

/// Real numbers from the helper's own response records (server-computed).
class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.stats});
  final HelperStats stats;

  @override
  Widget build(BuildContext context) {
    Widget cell(IconData icon, Color color, String value, String label) => Expanded(
          child: Column(children: [
            Icon(icon, color: color),
            SizedBox(height: 4),
            Text(value, style: TextStyle(color: context.hp.textPrimary, fontWeight: FontWeight.w800, fontSize: 18)),
            Text(label, style: TextStyle(color: context.hp.textSecondary, fontSize: 12)),
          ]),
        );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(color: context.hp.surface, borderRadius: BorderRadius.circular(18)),
      child: Row(children: [
        cell(Icons.assignment_turned_in_rounded, context.hp.primary, '${stats.responses}', 'Responses'),
        cell(Icons.star_rounded, Color(0xFF16A34A), stats.successLabel, 'Success'),
        cell(Icons.schedule_rounded, Color(0xFF2563EB), stats.avgLabel, 'Avg Time'),
      ]),
    );
  }
}