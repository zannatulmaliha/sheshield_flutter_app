import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/hooks/use_async_action.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/core/utils/context_extensions.dart';
import 'package:sheshield/features/admin/presentation/providers/admin_queue_provider.dart';
import 'package:sheshield/features/admin/presentation/widgets/admin_section_card.dart';
import 'package:sheshield/features/admin/presentation/widgets/suspend_helper_confirmation.dart';

/// Spec §6 fast-track suspension. Deliberately NOT gated on the review
/// being finished: a credible danger report suspends immediately.
class HelperSuspensionPanel extends HookConsumerWidget {
  const HelperSuspensionPanel({
    super.key,
    required this.palette,
    required this.helperUid,
    required this.isBusy,
  });

  final AppPalette palette;
  final String helperUid;
  final bool isBusy;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reasonController = useTextEditingController();
    final suspendAction = useAsyncAction();

    Future<void> suspendHelper() async {
      final reason = reasonController.text.trim();
      if (reason.isEmpty) {
        context.showMessage('A reason is required before suspending.');
        return;
      }
      if (!await confirmHelperSuspension(context)) return;

      await suspendAction.run(
        () async {
          final releasedSosId = await ref
              .read(adminQueueControllerProvider.notifier)
              .suspendHelper(uid: helperUid, reason: reason);
          if (!context.mounted) return;
          context.showMessage(
            releasedSosId != null
                ? 'Suspended. Released SOS $releasedSosId to standby.'
                : 'Suspended.',
          );
        },
        onFailure: context.showMessage,
      );
    }

    return AdminSectionCard(
      palette: palette,
      title: 'Fast-track suspension (§6)',
      children: [
        Text(
          'Only for a credible report that a helper endangered a requester. '
          'Suspends immediately, before review completes.',
          style: TextStyle(fontSize: 12, color: palette.textSecondary),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: reasonController,
          decoration: const InputDecoration(
            labelText: 'Reason (required)',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(foregroundColor: AppTheme.accentRed),
            onPressed: isBusy || suspendAction.isRunning ? null : suspendHelper,
            child: const Text('Suspend helper now'),
          ),
        ),
      ],
    );
  }
}
