import 'package:flutter/material.dart';
import '../models/app_badge.dart';
import '../state/game_scope.dart';
import '../theme/app_theme.dart';

class BadgeGrid extends StatelessWidget {
  const BadgeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final game = GameScope.of(context);
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.86,
      children: allBadges.map((b) => _BadgeTile(badge: b, unlocked: game.hasBadge(b.id))).toList(),
    );
  }
}

class _BadgeTile extends StatefulWidget {
  const _BadgeTile({required this.badge, required this.unlocked});

  final AppBadge badge;
  final bool unlocked;

  @override
  State<_BadgeTile> createState() => _BadgeTileState();
}

class _BadgeTileState extends State<_BadgeTile> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showDetails() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _BadgeDetailSheet(badge: widget.badge, unlocked: widget.unlocked),
    );
  }

  @override
  Widget build(BuildContext context) {
    final badge = widget.badge;
    final unlocked = widget.unlocked;
    return GestureDetector(
      onTap: _showDetails,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: softShadow(opacity: 0.06),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final glow = unlocked ? 0.18 + _controller.value * 0.18 : 0.0;
                return Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: unlocked ? badge.color.withValues(alpha: 0.14) : const Color(0xFFF1EEF4),
                    boxShadow: unlocked
                        ? [BoxShadow(color: badge.color.withValues(alpha: glow), blurRadius: 14, spreadRadius: 1)]
                        : null,
                  ),
                  child: child,
                );
              },
              child: Icon(
                unlocked ? badge.icon : Icons.lock_rounded,
                color: unlocked ? badge.color : AppColors.textSecondary,
                size: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              badge.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: unlocked ? AppColors.textPrimary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BadgeDetailSheet extends StatelessWidget {
  const _BadgeDetailSheet({required this.badge, required this.unlocked});

  final AppBadge badge;
  final bool unlocked;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (unlocked ? badge.color : AppColors.textSecondary).withValues(alpha: 0.14),
              ),
              child: Icon(
                unlocked ? badge.icon : Icons.lock_rounded,
                color: unlocked ? badge.color : AppColors.textSecondary,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),
            Text(badge.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              unlocked ? badge.description : 'Locked · ${badge.description}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
