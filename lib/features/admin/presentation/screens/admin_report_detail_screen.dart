import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/admin/domain/entities/admin_report_detail.dart';
import 'package:sheshield/features/admin/presentation/providers/admin_report_detail_provider.dart';
import 'package:sheshield/features/admin/presentation/widgets/admin_async_body.dart';
import 'package:sheshield/features/admin/presentation/widgets/admin_scaffold.dart';
import 'package:sheshield/features/admin/presentation/widgets/audit_trail_card.dart';
import 'package:sheshield/features/admin/presentation/widgets/helper_suspension_panel.dart';
import 'package:sheshield/features/admin/presentation/widgets/report_review_panel.dart';
import 'package:sheshield/features/admin/presentation/widgets/report_summary_card.dart';

/// One report plus the reported account's audit trail -- everything a
/// reviewer needs on one screen. Reviewing and fast-track suspension are
/// independent actions (see their panels).
class AdminReportDetailScreen extends ConsumerWidget {
  const AdminReportDetailScreen({super.key, required this.reportId});

  final String reportId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context);

    return AdminScaffold(
      title: l10n.adminReportDetailTitle,
      body: AdminAsyncBody<AdminReportDetail>(
        value: ref.watch(adminReportDetailControllerProvider(reportId)),
        builder: (detail) => ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
          children: [
            ReportSummaryCard(palette: palette, report: detail.report),
            const SizedBox(height: 16),
            AuditTrailCard(palette: palette, entries: detail.auditTrail),
            if (detail.report.isAwaitingDecision) ...[
              const SizedBox(height: 16),
              ReportReviewPanel(
                palette: palette,
                reportId: reportId,
                isBusy: false,
              ),
              const SizedBox(height: 16),
              HelperSuspensionPanel(
                palette: palette,
                helperUid: detail.report.reportedId,
                isBusy: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
