import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/user/domain/entities/time_of_day_risk.dart';

class RouteRiskBadge extends StatelessWidget {
  const RouteRiskBadge({super.key, required this.palette, this.now});

  final AppPalette palette;

  /// Overridable for tests; defaults to the current time.
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final risk = TimeOfDayRisk.at(now ?? DateTime.now());
    final color = switch (risk) {
      TimeOfDayRisk.low => palette.success,
      TimeOfDayRisk.medium => palette.warning,
      TimeOfDayRisk.high => palette.sosEnd,
    };

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            'Current risk: ${risk.label} (time of day)',
            style: TextStyle(color: color, fontSize: 10.5, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
