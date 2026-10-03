import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/error/error_message.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/features/helper/domain/entities/nearby_alert.dart';
import 'package:sheshield/features/helper/presentation/widgets/nearby_alert_card.dart';

/// "Nearby alerts (n)" heading plus the cards, with loading and error rows.
class NearbyAlertsSection extends StatelessWidget {
  const NearbyAlertsSection({
    super.key,
    required this.alertsState,
    required this.onAccept,
  });

  final AsyncValue<List<NearbyAlert>> alertsState;
  final ValueChanged<NearbyAlert> onAccept;

  @override
  Widget build(BuildContext context) {
    final alerts = alertsState.valueOrNull ?? const <NearbyAlert>[];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ICU plural message: the count picks the =0 / =1 / other branch.
        Text(
          AppLocalizations.of(context).nearbyAlertsCount(alerts.length),
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        if (alertsState.hasError)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              'Could not load alerts: ${describeErrorForUser(alertsState.error!)}',
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        if (alertsState.isLoading && alerts.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(child: CircularProgressIndicator()),
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
    );
  }
}
