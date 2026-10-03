import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/sos/domain/entities/sos_alert.dart';

/// Check mark, "SOS Alert Sent", and how many contacts were reached.
class SosSentHeader extends StatelessWidget {
  const SosSentHeader({super.key, required this.alert, required this.palette});

  final SosAlert? alert;
  final AppPalette palette;

  String get _deliverySummary {
    final total = alert?.deliveries.length ?? 0;
    final failedCount = alert?.failedCount ?? 0;
    if (total == 0) {
      return 'Your trusted contacts have been notified with your live location.';
    }
    if (failedCount == 0) {
      return 'Notified all $total trusted contact${total == 1 ? '' : 's'} with your live location.';
    }
    return 'Notified ${alert!.sentCount} of $total contacts. '
        '$failedCount could not be reached -- try calling them directly.';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 700),
          curve: Curves.elasticOut,
          builder: (context, value, child) => Transform.scale(scale: value, child: child),
          child: Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: palette.sosGradient),
            ),
            child: const Icon(Icons.check_rounded, color: Colors.white, size: 52),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'SOS Alert Sent',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        Text(
          _deliverySummary,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
        ),
      ],
    );
  }
}
