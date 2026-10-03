import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_theme.dart';

/// Resolves true only when the reviewer confirms an immediate suspension.
Future<bool> confirmHelperSuspension(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Suspend this helper now?'),
      content: const Text(
        'This immediately suspends them and releases any SOS they currently '
        'hold, before this report is reviewed. Use this only for a credible '
        'danger report -- ordinary abuse should go through Dismiss/Actioned '
        'instead.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: const Text(
            'Suspend',
            style: TextStyle(color: AppTheme.accentRed),
          ),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
