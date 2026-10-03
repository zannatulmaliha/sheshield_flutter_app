import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/sos/domain/entities/alert_status.dart';
import 'package:sheshield/features/sos/domain/entities/alert_summary.dart';
import 'package:sheshield/features/sos/presentation/widgets/alert_status_chip.dart';
import 'package:sheshield/features/sos/presentation/widgets/chat_with_helper_button.dart';

class AlertHistoryCard extends StatelessWidget {
  const AlertHistoryCard({
    super.key,
    required this.alert,
    required this.palette,
    required this.l10n,
  });

  final AlertSummary alert;
  final AppPalette palette;
  final AppLocalizations l10n;

  String get _statusLabel => switch (alert.status) {
        AlertStatus.active => l10n.alertStatusActive,
        AlertStatus.accepted => l10n.alertStatusAccepted,
        AlertStatus.resolved => l10n.alertStatusResolved,
      };

  Color get _statusColor => switch (alert.status) {
        AlertStatus.active => palette.sosStart,
        AlertStatus.accepted => palette.warning,
        AlertStatus.resolved => palette.success,
      };

  String get _deliverySummary {
    if (alert.totalCount == 0) return l10n.sosNotifiedFallback;
    if (alert.failedCount == 0) return l10n.sosNotifiedAll(alert.sentCount);
    return l10n.sosNotifiedPartial(alert.sentCount, alert.totalCount, alert.failedCount);
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.shield_rounded, color: statusColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        DateFormat('MMM d, y · h:mm a').format(alert.createdAt.toLocal()),
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13.5,
                          color: palette.textPrimary,
                        ),
                      ),
                    ),
                    AlertStatusChip(label: _statusLabel, color: statusColor),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  _deliverySummary,
                  style: TextStyle(
                    fontSize: 12.5,
                    color: palette.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // Only an ACCEPTED alert has a helper to talk to.
                if (alert.status == AlertStatus.accepted)
                  ChatWithHelperButton(alertId: alert.id, color: statusColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
