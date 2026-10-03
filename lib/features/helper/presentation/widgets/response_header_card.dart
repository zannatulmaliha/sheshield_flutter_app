import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/utils/time_ago.dart';
import 'package:sheshield/features/helper/domain/entities/accepted_alert.dart';
import 'package:sheshield/features/helper/domain/entities/response_stage.dart';

/// Who is being helped (first name only on screen), when it was accepted,
/// and the current stage chip.
class ResponseHeaderCard extends StatelessWidget {
  const ResponseHeaderCard({
    super.key,
    required this.alert,
    required this.stage,
    required this.palette,
  });

  static const _stageColor = Color(0xFF3B82F6);

  final AcceptedAlert alert;
  final ResponseStage stage;
  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    final initial = alert.userName.isEmpty ? '?' : alert.userName[0].toUpperCase();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: palette.primary,
            child: Text(
              initial,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert.userName,
                  style: TextStyle(
                    color: palette.textPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Accepted ${formatTimeAgo(alert.acceptedAt)}',
                  style: TextStyle(color: palette.textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _stageColor.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              stage.label,
              style: const TextStyle(
                color: _stageColor,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
