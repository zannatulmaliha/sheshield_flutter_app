import 'package:flutter/material.dart';

Future<bool> _confirm(
  BuildContext context, {
  required String title,
  required String message,
  required String cancelLabel,
  required String confirmLabel,
}) async {
  final isConfirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: Text(cancelLabel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return isConfirmed ?? false;
}

Future<bool> confirmResolveAlert(BuildContext context) => _confirm(
      context,
      title: 'Mark as resolved?',
      message: "This closes the alert and ends your access to the person's "
          'location and chat. Only do this once they are safe.',
      cancelLabel: 'Not yet',
      confirmLabel: 'Resolved',
    );

Future<bool> confirmBackOutOfAlert(BuildContext context) => _confirm(
      context,
      title: "Can't help with this?",
      message: 'This hands the alert back to other nearby helpers. Only do this '
          "if the situation seems unsafe, suspicious, or you truly can't respond.",
      cancelLabel: 'Stay on it',
      confirmLabel: 'Back out',
    );
