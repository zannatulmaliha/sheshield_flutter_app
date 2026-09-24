import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import '../../domain/entities/admin_report.dart';

class ReportQueueTile extends StatelessWidget {
  const ReportQueueTile(
      {super.key,
      required this.report,
      required this.colors,
      required this.onTap});

  final AdminReport report;
  final AppPalette colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // A system-filed report (an automated rate-limit flag) is visually
    // distinguished but sits in the exact same queue as a human report --
    // never a separate, lower-scrutiny lane. See the spec's bias
    // safeguard: this tile is only ever a prompt to look closer.
    final roleColor =
        report.isSystemFlag ? AppTheme.accentAmber : AppTheme.accentRed;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border:
              Border.all(color: colors.textSecondary.withValues(alpha: 0.12)),
        ),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.only(right: 12),
              decoration:
                  BoxDecoration(color: roleColor, shape: BoxShape.circle),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${report.category} · reported by ${report.reporterRole}',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: colors.textPrimary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat.yMMMd()
                        .add_jm()
                        .format(report.createdAt.toLocal()),
                    style: TextStyle(fontSize: 12, color: colors.textSecondary),
                  ),
                  if (report.sosId != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      'Linked SOS · tied to an active/past emergency',
                      style: TextStyle(
                          fontSize: 11,
                          color: colors.textSecondary.withValues(alpha: 0.8)),
                    ),
                  ],
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: colors.textSecondary),
          ],
        ),
      ),
    );
  }
}
