import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/error/error_message.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/helper/domain/entities/nearby_alert.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_status_provider.dart';
import 'package:sheshield/features/helper/presentation/providers/nearby_alerts_provider.dart';
import 'package:sheshield/features/helper/presentation/widgets/nearby_alert_card.dart';

/// First tab of the Alerts screen: the radius line plus the alert cards.
class NearbyAlertsTab extends ConsumerWidget {
  const NearbyAlertsTab({super.key, required this.onAccept});

  final ValueChanged<NearbyAlert> onAccept;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final alertsState = ref.watch(nearbyAlertsControllerProvider);
    final status = ref.watch(helperStatusControllerProvider).valueOrNull;
    final alerts = alertsState.valueOrNull ?? const <NearbyAlert>[];

    final emptyText = alertsState.hasError
        ? 'Could not load alerts: ${describeErrorForUser(alertsState.error!)}'
        : 'No active SOS calls nearby.';

    return RefreshIndicator(
      onRefresh: () => ref.read(nearbyAlertsControllerProvider.notifier).refresh(),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
        children: [
          if (status != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                status.isActive
                    ? 'Showing alerts within ${status.radiusKm.round()}km'
                    : 'You are inactive. Go active on the Dashboard to receive alerts.',
                style: TextStyle(color: palette.textSecondary),
              ),
            ),
          if (alertsState.isLoading && alerts.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              ),
            )
          else if (alerts.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Text(emptyText, style: TextStyle(color: palette.textSecondary)),
              ),
            )
          else
            for (final alert in alerts)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: NearbyAlertCard(
                  alert: alert,
                  isBusy: false,
                  onAccept: () => onAccept(alert),
                ),
              ),
        ],
      ),
    );
  }
}
