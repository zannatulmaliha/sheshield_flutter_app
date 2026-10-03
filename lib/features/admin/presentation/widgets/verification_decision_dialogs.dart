import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Resolves true only when the reviewer confirms the approval.
Future<bool> confirmVerificationApproval(BuildContext context) async {
  final approved = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Approve helper?'),
      content: const Text(
        'This marks the helper as identity-verified and allows helper '
        'functionality.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Approve'),
        ),
      ],
    ),
  );
  return approved ?? false;
}

/// Resolves the typed rejection reason, or null when cancelled / empty.
Future<String?> askVerificationRejectionReason(BuildContext context) async {
  final reason = await showDialog<String>(
    context: context,
    builder: (_) => const _RejectionReasonDialog(),
  );
  return (reason == null || reason.isEmpty) ? null : reason;
}

class _RejectionReasonDialog extends HookWidget {
  const _RejectionReasonDialog();

  @override
  Widget build(BuildContext context) {
    final reasonController = useTextEditingController();

    return AlertDialog(
      title: const Text('Reject verification'),
      content: TextField(
        controller: reasonController,
        maxLines: 3,
        decoration: const InputDecoration(
          labelText: 'Reason',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, reasonController.text.trim()),
          child: const Text('Reject'),
        ),
      ],
    );
  }
}
