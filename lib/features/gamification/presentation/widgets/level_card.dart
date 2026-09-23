import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/gamification/presentation/providers/gamification_provider.dart';

/// Home-screen hero showing Guardian Level and an animated XP bar.
/// Ported from the UI_Screens prototype's `LevelCard`, reading from
/// [gamificationControllerProvider] instead of `GameScope`. The demo's
/// hardcoded safety-streak chip was dropped -- there's no real
/// day-by-day activity tracking behind it here, and this app doesn't
/// show numbers it can't back (see how SMS delivery is reported as
/// `simulated` rather than `sent` when that's the truth).
class LevelCard extends ConsumerWidget {
  const LevelCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gamificationControllerProvider);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: softShadow(opacity: 0.08),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const _LevelBadgeIcon(),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Level ${game.level} · ${game.tierTitle}',
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${game.xpIntoLevel}/${GamificationState.xpPerLevel} XP to next level',
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 11.5, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: game.progress),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              builder: (context, value, _) => LinearProgressIndicator(
                value: value,
                minHeight: 10,
                backgroundColor: AppColors.chipBackground,
                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelBadgeIcon extends StatefulWidget {
  const _LevelBadgeIcon();

  @override
  State<_LevelBadgeIcon> createState() => _LevelBadgeIconState();
}

class _LevelBadgeIconState extends State<_LevelBadgeIcon> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final glow = 0.25 + _controller.value * 0.25;
        return Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(colors: AppColors.heroGradient),
            boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: glow), blurRadius: 18, spreadRadius: 2)],
          ),
          child: child,
        );
      },
      child: const Icon(Icons.sports_martial_arts_rounded, color: Colors.white, size: 26),
    );
  }
}
