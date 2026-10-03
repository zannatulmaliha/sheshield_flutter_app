import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/admin/domain/entities/admin_report.dart';

/// One queue row. System-filed flags (automated rate-limit) are tinted
/// differently but sit in the same queue as human reports -- never a
/// separate, lower-scrutiny lane (spec bias safeguard).
class ReportQueueTile extends StatelessWidget {
  const ReportQueueTile({
    super.key,
    required this.report,
    required this.palette,
    required this.onTap,
  });

  final AdminReport report;
  final AppPalette palette;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final roleColor =
        report.isSystemFlag ? AppTheme.accentAmber : AppTheme.accentRed;
    final filedAt = DateFormat.yMMMd().add_jm().format(report.createdAt.toLocal());

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: palette.textSecondary.withValues(alpha: 0.12)),
        ),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(color: roleColor, shape: BoxShape.circle),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${report.category} · reported by ${report.reporterRole.wireValue}',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: palette.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    filedAt,
                    style: TextStyle(fontSize: 12, color: palette.textSecondary),
                  ),
                  if (report.sosId != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      'Linked SOS · tied to an active/past emergency',
                      style: TextStyle(
                        fontSize: 11,
                        color: palette.textSecondary.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: palette.textSecondary),
          ],
        ),
      ),
    );
  }
}
