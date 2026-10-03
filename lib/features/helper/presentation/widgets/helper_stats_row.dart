import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/helper/domain/entities/helper_stats.dart';

/// Real numbers from the helper's own response records (server-computed).
class HelperStatsRow extends StatelessWidget {
  const HelperStatsRow({super.key, required this.stats, required this.palette});

  final HelperStats stats;
  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          _StatCell(
            icon: Icons.assignment_turned_in_rounded,
            color: palette.primary,
            value: '${stats.responses}',
            label: 'Responses',
            palette: palette,
          ),
          _StatCell(
            icon: Icons.star_rounded,
            color: const Color(0xFF16A34A),
            value: stats.successLabel,
            label: 'Success',
            palette: palette,
          ),
          _StatCell(
            icon: Icons.schedule_rounded,
            color: const Color(0xFF2563EB),
            value: stats.avgLabel,
            label: 'Avg Time',
            palette: palette,
          ),
        ],
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
    required this.palette,
  });

  final IconData icon;
  final Color color;
  final String value;
  final String label;
  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: palette.textPrimary,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          Text(label, style: TextStyle(color: palette.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }
}
