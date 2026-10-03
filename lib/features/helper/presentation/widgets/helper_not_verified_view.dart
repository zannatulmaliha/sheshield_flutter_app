import 'package:flutter/material.dart';
import 'package:sheshield/features/helper/presentation/helper_colors.dart';
import 'package:sheshield/core/theme/app_theme.dart';

class HelperNotVerifiedView extends StatelessWidget {
  const HelperNotVerifiedView({super.key, required this.onVerify});
  final VoidCallback onVerify;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.hourglass_empty_rounded, size: 48, color: AppTheme.accentOrange),
            const SizedBox(height: 16),
            Text(
              'Get verified to start responding',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: context.hp.textPrimary),
            ),
            const SizedBox(height: 8),
            Text(
              'Helpers must be verified before they can see or accept SOS alerts.',
              textAlign: TextAlign.center,
              style: TextStyle(color: context.hp.textSecondary, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onVerify,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.hp.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Get verified', style: TextStyle(fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      ),
    );
  }
}