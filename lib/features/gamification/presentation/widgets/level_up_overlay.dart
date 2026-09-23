import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_theme.dart';

import 'confetti_burst.dart';

/// Ported from the UI_Screens prototype unchanged.
Future<void> showLevelUpCelebration(
  BuildContext context, {
  required int level,
  required String tierTitle,
}) {
  return Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      barrierColor: Colors.black87,
      pageBuilder: (context, animation, secondaryAnimation) =>
          LevelUpOverlay(level: level, tierTitle: tierTitle),
    ),
  );
}

class LevelUpOverlay extends StatelessWidget {
  const LevelUpOverlay({super.key, required this.level, required this.tierTitle});

  final int level;
  final String tierTitle;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          const Positioned.fill(child: ConfettiBurst()),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 650),
                    curve: Curves.elasticOut,
                    builder: (context, value, child) => Transform.scale(scale: value, child: child),
                    child: Container(
                      width: 108,
                      height: 108,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: AppColors.heroGradient),
                      ),
                      child: const Icon(Icons.military_tech_rounded, color: Colors.white, size: 56),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Level $level Unlocked!',
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You are now a $tierTitle',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primaryDark,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Keep Going', style: TextStyle(fontWeight: FontWeight.w800)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
