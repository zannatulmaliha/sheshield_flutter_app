import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_theme.dart';

/// Full-screen message for the pending/approved states (the form itself
/// only appears for none/rejected -- see VerificationScreen).
class VerificationStatusView extends StatelessWidget {
  const VerificationStatusView({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.message,
    required this.buttonLabel,
    required this.onButton,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String message;
  final String buttonLabel;
  final VoidCallback onButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: Column(
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color.withValues(alpha: 0.14)),
            child: Icon(icon, size: 44, color: color),
          ),
          const SizedBox(height: 20),
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 21, color: AppColors.textPrimary)),
          const SizedBox(height: 10),
          Text(message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13.5, height: 1.5)),
          const SizedBox(height: 24),
          OutlinedButton(onPressed: onButton, child: Text(buttonLabel)),
        ],
      ),
    );
  }
}