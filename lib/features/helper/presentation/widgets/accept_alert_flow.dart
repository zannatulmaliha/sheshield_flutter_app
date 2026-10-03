import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/error/app_failure.dart';
import 'package:sheshield/core/utils/context_extensions.dart';
import 'package:sheshield/features/helper/domain/entities/accepted_alert.dart';
import 'package:sheshield/features/helper/domain/entities/nearby_alert.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_activity_providers.dart';
import 'package:sheshield/features/helper/presentation/providers/nearby_alerts_provider.dart';

Future<bool> _confirmAccept(BuildContext context, NearbyAlert alert) async {
  final isConfirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Accept this alert?'),
      content: Text(
        '${alert.label}. You will get the exact location and phone number of '
        'the person ${alert.distanceLabel}, near ${alert.roughArea}. '
        'Only accept if you can get there safely.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Accept'),
        ),
      ],
    ),
  );
  return isConfirmed ?? false;
}

/// Confirm -> accept -> report the outcome. Returns the accepted alert, or
/// null when the person cancelled, someone else won the race, or the
/// request failed (each already explained to them here).
Future<AcceptedAlert?> runAcceptAlertFlow(
  BuildContext context,
  WidgetRef ref,
  NearbyAlert alert,
) async {
  if (!await _confirmAccept(context, alert)) return null;
  if (!context.mounted) return null;

  try {
    final acceptedAlert =
        await ref.read(nearbyAlertsControllerProvider.notifier).accept(alert.id);
    if (acceptedAlert == null) {
      if (context.mounted) {
        context.showMessage('Someone else already responded to this alert.');
      }
      return null;
    }
    ref.invalidate(myResponseProvider);
    return acceptedAlert;
  } on AppFailure catch (failure) {
    if (context.mounted) context.showMessage(failure.message);
    return null;
  }
}
