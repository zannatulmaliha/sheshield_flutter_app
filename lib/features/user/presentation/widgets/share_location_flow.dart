import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/utils/context_extensions.dart';
import 'package:sheshield/features/user/presentation/providers/share_location_provider.dart';

/// Confirm -> send the current location to every trusted contact by SMS ->
/// report the outcome.
Future<void> runShareLocationFlow(BuildContext context, WidgetRef ref) async {
  final l10n = AppLocalizations.of(context);
  final isConfirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(l10n.shareLocation),
      content: const Text('Send your current location to all trusted contacts by SMS?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: const Text('Send'),
        ),
      ],
    ),
  );
  if (isConfirmed != true || !context.mounted) return;

  final failureMessage =
      await ref.read(shareLocationControllerProvider.notifier).share();
  if (context.mounted) {
    context.showMessage(failureMessage ?? 'Location sent to your trusted contacts.');
  }
}
