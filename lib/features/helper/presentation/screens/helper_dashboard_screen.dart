import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/features/helper/domain/entities/nearby_alert.dart';
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
        const Duration(seconds: 15),
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
        title: const Text('Accept this alert?'),
        content: Text(
          'You will get the exact location and phone number for the '
          'person ${alert.distanceLabel}, near ${alert.roughArea}.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Accept')),
        ],
      ),
    );
    if (confirmed != true) return;

    final accepted = await ref.read(nearbyAlertsControllerProvider.notifier).accept(alert.id);
    if (!mounted) return;

    if (accepted != null) {
      HelperAlertDetailRoute($extra: accepted).push(context);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Someone else already responded to this alert.')),
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
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
      data: (status) => SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () => ref.read(nearbyAlertsControllerProvider.notifier).refresh(),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
            children: [
              Text(
                AppLocalizations.of(context)!.helperDashboard,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              ActiveHelperCard(
                status: status,
                isBusy: statusAsync.isLoading,
                onToggle: _onToggle,
                onRadiusChanged: (km) =>
                    ref.read(helperStatusControllerProvider.notifier).setRadius(km),
              ),
              const SizedBox(height: 22),
              if (status.isActive)
                ..._alertsSection(alertsAsync)
              else
                const InactiveHelperHint(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _alertsSection(AsyncValue<List<NearbyAlert>> alertsAsync) {
    final alerts = alertsAsync.valueOrNull ?? const <NearbyAlert>[];
    return [
      // ICU plural message -- the count drives which of the =0/=1/other
      // branches renders (and, for locales with richer plural rules
      // than English, e.g. some Arabic/Slavic forms, intl handles
      // those extra branches too if added to the .arb entry).
      Text(
        AppLocalizations.of(context)!.nearbyAlertsCount(alerts.length),
        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 12),
      if (alertsAsync.isLoading && alerts.isEmpty)
        const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Center(child: CircularProgressIndicator()),
        )
      else
        for (final alert in alerts)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: NearbyAlertCard(alert: alert, isBusy: false, onAccept: () => _onAccept(alert)),
          ),
    ];
  }
}
