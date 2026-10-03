import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/contacts/domain/entities/trusted_contact.dart';

/// Resolves true only when the person confirms the removal.
Future<bool?> confirmContactRemoval(
  BuildContext context, {
  required TrustedContact contact,
  required AppPalette palette,
}) {
  return showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Remove contact?'),
      content: Text('${contact.name} will no longer receive your SOS alerts.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: Text('Remove', style: TextStyle(color: palette.sosEnd)),
        ),
      ],
    ),
  );
}
