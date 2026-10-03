import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';

class SafetyRemindersCard extends StatelessWidget {
  const SafetyRemindersCard({super.key, required this.palette});

  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEA580C).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Color(0xFFC2410C), size: 18),
              const SizedBox(width: 6),
              Text(
                'Safety reminders',
                style: TextStyle(
                  color: palette.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '- Keep talking to the person through the in-app chat\n'
            "- Don't put yourself in danger\n"
            '- Call 999 if the situation escalates\n'
            '- Stay in well-lit, public areas when possible',
            style: TextStyle(color: palette.textSecondary, fontSize: 12.5, height: 1.5),
          ),
        ],
      ),
    );
  }
}
