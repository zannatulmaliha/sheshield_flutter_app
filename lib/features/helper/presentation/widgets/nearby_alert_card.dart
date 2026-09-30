import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/helper/domain/entities/nearby_alert.dart';

class NearbyAlertCard extends StatelessWidget {
  const NearbyAlertCard({
    super.key,
    required this.alert,
    required this.isBusy,
    required this.onAccept,
  });

  final NearbyAlert alert;
  final bool isBusy;
  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.07), blurRadius: 16, offset: const Offset(0, 6)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: AppTheme.accentRed.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: const Icon(Icons.warning_rounded, color: AppTheme.accentRed),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(alert.distanceLabel,
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Colors.black87)),
                const SizedBox(height: 2),
                Text('Near ${alert.roughArea}',
                    style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600)),
                if (alert.mutualConnection) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.accentEmerald.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.link_rounded, size: 13, color: AppTheme.accentEmerald),
                        const SizedBox(width: 4),
                        Text(
                          'Connected via a mutual contact',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.accentEmerald.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          ElevatedButton(
            onPressed: isBusy ? null : onAccept,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentEmerald,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Accept', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}
