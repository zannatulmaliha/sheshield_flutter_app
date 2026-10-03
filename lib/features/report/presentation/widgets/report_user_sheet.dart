import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/core/utils/context_extensions.dart';
import 'package:sheshield/features/report/domain/entities/report_category.dart';
import 'package:sheshield/features/report/presentation/providers/report_submitter.dart';
import 'package:sheshield/features/report/presentation/widgets/report_category_picker.dart';

typedef ReportSelection = ({ReportCategory category, bool alsoBlock});

/// Opens the report sheet, then files the report (and an optional block --
/// one-tap, reversible, spec §5) and shows the outcome in a snackbar.
Future<void> showReportUserSheet(
  BuildContext context, {
  required String reportedId,
  required String reporterRole,
  String? sosId,
}) async {
  final reportSubmitter = ProviderScope.containerOf(context).read(reportSubmitterProvider);

  final selection = await showModalBottomSheet<ReportSelection>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const ReportUserSheet(),
  );
  if (selection == null) return;

  final messages = await reportSubmitter.submit(
    reportedId: reportedId,
    category: selection.category,
    reporterRole: reporterRole,
    alsoBlock: selection.alsoBlock,
    sosId: sosId,
  );
  if (context.mounted) context.showMessage(messages.join('\n'));
}

class ReportUserSheet extends HookConsumerWidget {
  const ReportUserSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final selectedCategory = useState<ReportCategory?>(null);
    final alsoBlock = useState(false);

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: softShadow(opacity: 0.18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'What happened?',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 17,
                color: palette.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'This goes to a human reviewer, not an automated system.',
              style: TextStyle(fontSize: 12.5, color: palette.textSecondary),
            ),
            const SizedBox(height: 8),
            ReportCategoryPicker(
              selectedCategory: selectedCategory.value,
              onCategoryChanged: (category) => selectedCategory.value = category,
              palette: palette,
            ),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: alsoBlock.value,
              onChanged: (isChecked) => alsoBlock.value = isChecked ?? false,
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: palette.primary,
              title: Text(
                'Also block this person',
                style: TextStyle(
                  color: palette.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _SubmitReportButton(
              palette: palette,
              onPressed: selectedCategory.value == null
                  ? null
                  : () => Navigator.of(context).pop((
                        category: selectedCategory.value!,
                        alsoBlock: alsoBlock.value,
                      ),),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubmitReportButton extends StatelessWidget {
  const _SubmitReportButton({required this.palette, required this.onPressed});

  final AppPalette palette;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: palette.sosEnd,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: onPressed,
      child: const Text(
        'Submit report',
        style: TextStyle(fontWeight: FontWeight.w800),
      ),
    );
  }
}
