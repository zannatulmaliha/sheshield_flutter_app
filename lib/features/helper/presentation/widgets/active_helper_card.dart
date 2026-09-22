import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/helper/domain/entities/helper_status.dart';

/// Pure display widget -- takes the current [HelperStatus] and reports
/// user intent via callbacks. It never reads a provider itself, so it
/// stays trivially testable with plain widget tests.
class ActiveHelperCard extends StatelessWidget {
  const ActiveHelperCard({
    super.key,
    required this.status,
    required this.isBusy,
    required this.onToggle,
    required this.onRadiusChanged,
  });

  final HelperStatus status;
  final bool isBusy;
  final ValueChanged<bool> onToggle;
  final ValueChanged<double> onRadiusChanged;

  @override
  Widget build(BuildContext context) {
    final active = status.isActive;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: active
            ? LinearGradient(
                colors: AppTheme.heroGradient ?? const [Colors.teal, Colors.green],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: active ? null : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: (active ? AppTheme.accentEmerald : Colors.black)
                .withValues(alpha: active ? 0.28 : 0.07),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shield_moon_rounded, color: active ? Colors.white : AppTheme.accentEmerald),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  active ? "You're active" : 'Go active to respond to alerts',
                  style: TextStyle(
                    color: active ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
              if (isBusy)
                SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: active ? Colors.white : AppTheme.accentEmerald,
                  ),
                )
              else
                Switch(
                  value: active,
                  onChanged: onToggle,
                  activeThumbColor: Colors.white,
                  activeTrackColor: Colors.white.withValues(alpha: 0.4),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Response radius: ${status.radiusKm.toStringAsFixed(1)} km',
            style: TextStyle(
              color: active ? Colors.white.withValues(alpha: 0.9) : Colors.black54,
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
            ),
          ),
          Slider(
            value: status.radiusKm,
            min: 1,
            max: 10,
            divisions: 18,
            activeColor: active ? Colors.white : AppTheme.accentEmerald,
            label: '${status.radiusKm.toStringAsFixed(1)} km',
            onChanged: onRadiusChanged,
          ),
        ],
      ),
    );
  }
}
