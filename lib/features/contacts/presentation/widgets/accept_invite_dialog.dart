import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/error/error_message.dart';
import 'package:sheshield/features/contacts/presentation/providers/accept_invite_provider.dart';

/// The invitee's side of the invite flow: redeems a code someone else's
/// invite produced, linking THIS account as their trusted contact so
/// their next SOS alarms this device instead of only texting it.
Future<void> showAcceptInviteDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (_) => const AcceptInviteDialog(),
  );
}

class AcceptInviteDialog extends HookConsumerWidget {
  const AcceptInviteDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final codeController = useTextEditingController();
    final acceptState = ref.watch(acceptInviteControllerProvider);
    final isLinked = acceptState.valueOrNull ?? false;

    if (isLinked) return const _LinkedDialog();

    void submitCode() {
      final code = codeController.text.trim();
      if (code.isEmpty) return;
      ref.read(acceptInviteControllerProvider.notifier).acceptCode(code);
    }

    return AlertDialog(
      title: const Text('Enter invite code'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enter the code someone shared with you to link your account '
            'as their trusted contact.',
          ),
          const SizedBox(height: 16),
          TextField(
            controller: codeController,
            autofocus: true,
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              hintText: 'e.g. AB12CD34',
              errorText: acceptState.hasError
                  ? describeErrorForUser(acceptState.error!)
                  : null,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: acceptState.isLoading ? null : submitCode,
          child: acceptState.isLoading
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Link account'),
        ),
      ],
    );
  }
}

class _LinkedDialog extends StatelessWidget {
  const _LinkedDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Linked!'),
      content: const Text(
        "You'll now get an instant alarm on your phone if they ever send an SOS.",
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Done'),
        ),
      ],
    );
  }
}
