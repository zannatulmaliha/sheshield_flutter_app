import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_provider.dart';
import 'package:sheshield/shared/entities/app_user.dart';

/// One reusable single-field edit sheet, used for name and address.
/// Kept generic so adding another editable field later is a one-line
/// call, not a new screen.
Future<void> showEditFieldSheet(
  BuildContext context,
  WidgetRef ref, {
  required String title,
  required String initialValue,
  required Future<void> Function(String value) onSave,
  int maxLength = 60,
}) {
  final TextEditingController controller = TextEditingController(text: initialValue);
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext sheetContext) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(sheetContext).textTheme.titleLarge),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              maxLength: maxLength,
              autofocus: true,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final String value = controller.text.trim();
                await onSave(value);
                if (sheetContext.mounted) {
                  Navigator.of(sheetContext).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      );
    },
  );
}

void showEditNameSheet(BuildContext context, WidgetRef ref, AppUser user) {
  showEditFieldSheet(
    context,
    ref,
    title: 'Edit name',
    initialValue: user.name,
    onSave: (String value) => ref.read(authControllerProvider.notifier).updateProfile(name: value),
  );
}

void showEditAddressSheet(BuildContext context, WidgetRef ref, AppUser user) {
  showEditFieldSheet(
    context,
    ref,
    title: 'Edit home address',
    initialValue: user.address ?? '',
    maxLength: 200,
    onSave: (String value) => ref.read(authControllerProvider.notifier).updateProfile(address: value),
  );
}