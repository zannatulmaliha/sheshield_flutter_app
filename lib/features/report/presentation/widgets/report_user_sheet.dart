import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import '../../domain/entities/report_category.dart';
import '../../domain/repositories/i_report_repository.dart';
import '../../domain/usecases/block_user_usecase.dart';
import '../../domain/usecases/file_report_usecase.dart';

/// Opens the report sheet, then (only if the person also chose to) confirms
/// and files a block -- one-tap, reversible, no explanation required (spec
/// §5). Shows a snackbar with the outcome; swallows nothing silently.
Future<void> showReportUserSheet(
  BuildContext context, {
  required String reportedId,
  required String reporterRole,
  String? sosId,
}) async {
  final messenger = ScaffoldMessenger.of(context);

  final result = await showModalBottomSheet<_ReportResult>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const _ReportUserSheet(),
  );
  if (result == null) return;

  try {
    await getIt<FileReportUseCase>().call(
      reportedId: reportedId,
      category: result.category,
      reporterRole: reporterRole,
      sosId: sosId,
    );
    messenger.showSnackBar(const SnackBar(content: Text('Report filed. A reviewer will look into this.')));
  } on ReportFailure catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(e.message)));
    return;
  }

  if (result.alsoBlock) {
    try {
      await getIt<BlockUserUseCase>().call(reportedId);
      messenger.showSnackBar(const SnackBar(content: Text('Blocked. You can unblock them anytime from Settings.')));
    } on ReportFailure catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}

class _ReportResult {
  const _ReportResult(this.category, this.alsoBlock);
  final ReportCategory category;
  final bool alsoBlock;
}

class _ReportUserSheet extends ConsumerStatefulWidget {
  const _ReportUserSheet();

  @override
  ConsumerState<_ReportUserSheet> createState() => _ReportUserSheetState();
}

class _ReportUserSheetState extends ConsumerState<_ReportUserSheet> {
  ReportCategory? _selected;
  bool _alsoBlock = false;

  @override
  Widget build(BuildContext context) {
    final colors = resolvePalette(context, ref);

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: softShadow(opacity: 0.18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'What happened?',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: colors.textPrimary),
            ),
            const SizedBox(height: 4),
            Text(
              'This goes to a human reviewer, not an automated system.',
              style: TextStyle(fontSize: 12.5, color: colors.textSecondary),
            ),
            const SizedBox(height: 8),
            RadioGroup<ReportCategory>(
              groupValue: _selected,
              onChanged: (v) => setState(() => _selected = v),
              child: Column(
                children: [
                  for (final category in ReportCategory.values)
                    RadioListTile<ReportCategory>(
                      contentPadding: EdgeInsets.zero,
                      value: category,
                      title: Text(category.label, style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w600)),
                      activeColor: colors.primary,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              value: _alsoBlock,
              onChanged: (v) => setState(() => _alsoBlock = v ?? false),
              controlAffinity: ListTileControlAffinity.leading,
              title: Text('Also block this person', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w600)),
              activeColor: colors.primary,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.sosEnd,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: _selected == null
                    ? null
                    : () => Navigator.of(context).pop(_ReportResult(_selected!, _alsoBlock)),
                child: const Text('Submit report', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
