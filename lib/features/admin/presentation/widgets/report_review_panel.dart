import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/hooks/use_async_action.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/utils/context_extensions.dart';
import 'package:sheshield/features/admin/domain/entities/review_decision.dart';
import 'package:sheshield/features/admin/presentation/providers/admin_queue_provider.dart';
import 'package:sheshield/features/admin/presentation/widgets/admin_section_card.dart';

/// Dismiss / Actioned controls with the required resolution note and the
/// optional false-SOS flag. Pops the screen once the review is saved.
class ReportReviewPanel extends HookConsumerWidget {
  const ReportReviewPanel({
    super.key,
    required this.palette,
    required this.reportId,
    required this.isBusy,
  });

  final AppPalette palette;
  final String reportId;

  /// True while a sibling action (e.g. suspension) is running.
  final bool isBusy;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resolutionController = useTextEditingController();
    final markFalseSos = useState(false);
    final reviewAction = useAsyncAction();
    final isDisabled = isBusy || reviewAction.isRunning;

    Future<void> submitReview(ReviewDecision decision) async {
      final resolution = resolutionController.text.trim();
      if (resolution.isEmpty) {
        context.showMessage('A short resolution note is required.');
        return;
      }
      final wasSaved = await reviewAction.run(
        () => ref.read(adminQueueControllerProvider.notifier).reviewReport(
              reportId: reportId,
              decision: decision,
              resolution: resolution,
              markFalseSos: markFalseSos.value,
            ),
        onFailure: context.showMessage,
      );
      if (wasSaved && context.mounted) Navigator.of(context).pop();
    }

    return AdminSectionCard(
      palette: palette,
      title: 'Review',
      children: [
        TextField(
          controller: resolutionController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Resolution note (required)',
            border: OutlineInputBorder(),
          ),
        ),
        CheckboxListTile(
          value: markFalseSos.value,
          onChanged: (isChecked) => markFalseSos.value = isChecked ?? false,
          contentPadding: EdgeInsets.zero,
          title: const Text(
            'Mark linked SOS as false (feeds review, never auto-restricts)',
            style: TextStyle(fontSize: 13),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: isDisabled
                    ? null
                    : () => submitReview(ReviewDecision.dismissed),
                child: const Text('Dismiss'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: isDisabled
                    ? null
                    : () => submitReview(ReviewDecision.actioned),
                child: const Text('Actioned'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
