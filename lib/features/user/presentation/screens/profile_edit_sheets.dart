import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_provider.dart';
import 'package:sheshield/shared/entities/app_user.dart';

/// One reusable single-field edit sheet, used for name and address. Kept
/// generic so adding another editable field later is a one-line call.
Future<void> showEditFieldSheet(
  BuildContext context, {
  required String title,
  required String initialValue,
  required Future<void> Function(String value) onSave,
  int maxLength = 60,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => EditFieldSheet(
      title: title,
      initialValue: initialValue,
      maxLength: maxLength,
      onSave: onSave,
    ),
  );
}

void showEditNameSheet(BuildContext context, WidgetRef ref, AppUser user) {
  showEditFieldSheet(
    context,
    title: 'Edit name',
    initialValue: user.name,
    onSave: (value) => ref.read(authControllerProvider.notifier).updateProfile(name: value),
  );
}

void showEditAddressSheet(BuildContext context, WidgetRef ref, AppUser user) {
  showEditFieldSheet(
    context,
    title: 'Edit home address',
    initialValue: user.address ?? '',
    maxLength: 200,
    onSave: (value) => ref.read(authControllerProvider.notifier).updateProfile(address: value),
  );
}

class EditFieldSheet extends HookWidget {
  const EditFieldSheet({
    super.key,
    required this.title,
    required this.initialValue,
    required this.maxLength,
    required this.onSave,
  });

  final String title;
  final String initialValue;
  final int maxLength;
  final Future<void> Function(String value) onSave;

  @override
  Widget build(BuildContext context) {
    // Owned by the widget, so it is disposed with the sheet.
    final textController = useTextEditingController(text: initialValue);

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          TextField(controller: textController, maxLength: maxLength, autofocus: true),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              await onSave(textController.text.trim());
              if (context.mounted) Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
