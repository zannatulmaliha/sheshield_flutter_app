import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/hooks/use_async_action.dart';
import 'package:sheshield/core/utils/context_extensions.dart';
import 'package:sheshield/features/admin/presentation/providers/admin_verification_detail_provider.dart';
import 'package:sheshield/features/admin/presentation/widgets/verification_decision_dialogs.dart';

/// Reject / Approve for a pending submission; pops the screen on success.
class VerificationDecisionButtons extends HookConsumerWidget {
  const VerificationDecisionButtons({super.key, required this.verificationId});

  final String verificationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decisionAction = useAsyncAction();

    Future<void> decide({required bool approved}) async {
      final note = approved ? '' : await askVerificationRejectionReason(context);
      if (!context.mounted) return;
      final isConfirmed = approved
          ? await confirmVerificationApproval(context)
          : note != null;
      if (!isConfirmed || !context.mounted) return;

      final wasSaved = await decisionAction.run(
        () => ref
            .read(adminVerificationDetailControllerProvider(verificationId).notifier)
            .decide(approved: approved, note: note ?? ''),
        onFailure: context.showMessage,
      );
      if (wasSaved && context.mounted) Navigator.pop(context);
    }

    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: decisionAction.isRunning ? null : () => decide(approved: false),
            icon: const Icon(Icons.close),
            label: const Text('Reject'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FilledButton.icon(
            onPressed: decisionAction.isRunning ? null : () => decide(approved: true),
            icon: const Icon(Icons.check),
            label: const Text('Approve'),
          ),
        ),
      ],
    );
  }
}
