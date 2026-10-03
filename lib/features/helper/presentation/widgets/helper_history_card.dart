import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/helper/domain/entities/helper_history_item.dart';
import 'package:sheshield/features/helper/domain/entities/response_outcome.dart';

/// One past response with its outcome badge.
class HelperHistoryCard extends StatelessWidget {
  const HelperHistoryCard({super.key, required this.item, required this.palette});

  final HelperHistoryItem item;
  final AppPalette palette;

  static String _formatDateTime(DateTime moment) {
    final local = moment.toLocal();
    String twoDigits(int value) => value.toString().padLeft(2, '0');
    return '${local.year}-${twoDigits(local.month)}-${twoDigits(local.day)} '
        '${twoDigits(local.hour)}:${twoDigits(local.minute)}';
  }

  @override
  Widget build(BuildContext context) {
    final (color, outcomeText, icon) = switch (item.outcome) {
      ResponseOutcome.resolved =>
        (const Color(0xFF16A34A), 'Resolved', Icons.check_circle_rounded),
      ResponseOutcome.released =>
        (const Color(0xFFD97706), 'Handed back', Icons.undo_rounded),
      ResponseOutcome.active =>
        (const Color(0xFF2563EB), 'In progress', Icons.directions_run_rounded),
    };
    final responseMinutes = item.responseMinutes;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: TextStyle(
                    color: palette.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatDateTime(item.acceptedAt),
                  style: TextStyle(color: palette.textSecondary, fontSize: 12),
                ),
                if (responseMinutes != null)
                  Text(
                    'Arrived in ${responseMinutes.round()} min',
                    style: TextStyle(color: palette.textSecondary, fontSize: 12),
                  ),
              ],
            ),
          ),
          Text(
            outcomeText,
            style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
