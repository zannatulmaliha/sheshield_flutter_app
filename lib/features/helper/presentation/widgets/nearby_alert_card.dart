import 'package:flutter/material.dart';
import 'package:sheshield/features/helper/presentation/helper_colors.dart';
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.hp.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.07), blurRadius: 16, offset: Offset(0, 6)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: (alert.isHighRisk ? AppTheme.accentRed : Colors.orange).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.warning_rounded, color: alert.isHighRisk ? AppTheme.accentRed : Colors.orange.shade800),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: (alert.isHighRisk ? Color(0xFFEF4444) : Color(0xFFF59E0B)).withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        alert.isHighRisk ? 'HIGH RISK' : 'MEDIUM RISK',
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w800,
                          color: alert.isHighRisk ? Color(0xFFEF4444) : Color(0xFFD97706),
                        ),
                      ),
                    ),
                    if (alert.duressActive) ...[
                      SizedBox(width: 6),
                      Text('DURESS', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w900, color: Color(0xFFEF4444))),
                    ],
                  ],
                ),
                SizedBox(height: 4),
                Text(alert.label, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: context.hp.textPrimary)),
                SizedBox(height: 2),
                Text('${alert.distanceLabel} - ~${alert.etaMinutes} min away',
                    style: TextStyle(fontSize: 12, color: context.hp.textSecondary, fontWeight: FontWeight.w600)),
                if (alert.mutualConnection) ...[
                  SizedBox(height: 6),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: context.hp.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.link_rounded, size: 13, color: context.hp.primary),
                        SizedBox(width: 4),
                        Text(
                          'Connected via a mutual contact',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: context.hp.primary.withValues(alpha: 0.9),
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
              backgroundColor: context.hp.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Accept', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}