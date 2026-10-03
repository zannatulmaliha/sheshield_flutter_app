import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/admin/domain/entities/admin_report.dart';
import 'package:sheshield/features/admin/presentation/widgets/admin_section_card.dart';

class ReportSummaryCard extends StatelessWidget {
  const ReportSummaryCard({super.key, required this.palette, required this.report});

  final AppPalette palette;
  final AdminReport report;

  @override
  Widget build(BuildContext context) {
    final filedAt = DateFormat.yMMMd().add_jm().format(report.createdAt.toLocal());

    return AdminSectionCard(
      palette: palette,
      title: 'Report',
      children: [
        AdminInfoRow(palette: palette, label: 'Category', value: report.category),
        AdminInfoRow(
          palette: palette,
          label: 'Reported by',
          value: report.reporterRole.wireValue,
        ),
        AdminInfoRow(
          palette: palette,
          label: 'Status',
          value: report.reviewStatus.wireValue,
        ),
        AdminInfoRow(palette: palette, label: 'Filed', value: filedAt),
        if (report.sosId != null)
          AdminInfoRow(palette: palette, label: 'Linked SOS', value: report.sosId!),
      ],
    );
  }
}
