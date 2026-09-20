import 'package:flutter/material.dart';
import '../models/helper_alert.dart';
import '../state/game_scope.dart';
import '../theme/app_theme.dart';
import 'level_up_overlay.dart';
import 'staggered_fade_in.dart';
import 'xp_toast.dart';

/// The volunteer-side view: go available, see stats, respond to nearby
/// SOS alerts. Reached from the segmented switch on the Profile screen.
class HelperDashboard extends StatelessWidget {
  const HelperDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final game = GameScope.of(context);
    return StaggeredFadeIn(
      children: [
        _AvailabilityCard(online: game.isHelperOnline),
        const SizedBox(height: 20),
        const _StatsRow(),
        const SizedBox(height: 24),
        Text('Nearby SOS Alerts', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        Text(
          game.isHelperOnline
              ? 'People near you who may need help right now.'
              : 'Turn on availability to see nearby alerts.',
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12.5, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 14),
        if (game.isHelperOnline)
          ...demoHelperAlerts.map((a) => _AlertCard(alert: a, responded: game.hasResponded(a.id)))
        else
          const _OfflineState(),
      ],
    );
  }
}

class _AvailabilityCard extends StatelessWidget {
  const _AvailabilityCard({required this.online});

  final bool online;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.helperGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: softShadow(color: const Color(0xFF3F5EFB), opacity: 0.28),
      ),
      child: Row(
        children: [
          _PulsingDot(active: online),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  online ? "You're Available" : "You're Offline",
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  online
                      ? 'Nearby SOS alerts will notify you instantly.'
                      : 'Switch on to start helping nearby Guardians.',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
          Switch(
            value: online,
            activeThumbColor: Colors.white,
            activeTrackColor: Colors.white.withValues(alpha: 0.4),
            onChanged: (v) => GameScope.read(context).setHelperOnline(v),
          ),
        ],
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  const _PulsingDot({required this.active});

  final bool active;

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active) {
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.18), shape: BoxShape.circle),
        child: const Icon(Icons.pause_rounded, color: Colors.white, size: 20),
      );
    }
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final glow = 0.25 + _controller.value * 0.3;
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.22),
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.white.withValues(alpha: glow), blurRadius: 14, spreadRadius: 2)],
          ),
          child: child,
        );
      },
      child: const Icon(Icons.volunteer_activism_rounded, color: Colors.white, size: 20),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _StatTile(icon: Icons.diversity_3_rounded, value: '12', label: 'People Helped', color: AppColors.primary)),
        SizedBox(width: 12),
        Expanded(child: _StatTile(icon: Icons.bolt_rounded, value: '4 min', label: 'Avg Response', color: Color(0xFF3F5EFB))),
        SizedBox(width: 12),
        Expanded(child: _StatTile(icon: Icons.star_rounded, value: '4.9', label: 'Rating', color: Color(0xFFFFA94D))),
      ],
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.icon, required this.value, required this.label, required this.color});

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: softShadow(opacity: 0.06),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.textPrimary)),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({required this.alert, required this.responded});

  final HelperAlert alert;
  final bool responded;

  void _respond(BuildContext context) {
    final game = GameScope.read(context);
    final isNew = game.respondToAlert(alert.id);
    if (!isNew) return;

    final leveledUp = game.addXp(20);
    final newBadge = game.unlockBadge('guardian_helper');
    if (leveledUp) {
      showLevelUpCelebration(context, level: game.level, tierTitle: game.tierTitle);
    } else if (newBadge) {
      showXpToast(context, 20, label: 'Guardian Helper unlocked');
    } else {
      showXpToast(context, 20, label: 'Thanks for helping!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: softShadow(opacity: 0.07),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: alert.color.withValues(alpha: 0.14), shape: BoxShape.circle),
                child: Icon(Icons.person_pin_circle_rounded, color: alert.color, size: 22),
              ),
              if (!responded)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: alert.color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(alert.label, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5, color: AppColors.textPrimary)),
                const SizedBox(height: 2),
                Text(
                  '${alert.distanceKm} km away · ${alert.minutesAgo} min ago',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 11.5, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          responded
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_rounded, color: AppColors.success, size: 15),
                      SizedBox(width: 4),
                      Text('On the way', style: TextStyle(color: AppColors.success, fontWeight: FontWeight.w800, fontSize: 11.5)),
                    ],
                  ),
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: alert.color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => _respond(context),
                  child: const Text('Respond', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                ),
        ],
      ),
    );
  }
}

class _OfflineState extends StatelessWidget {
  const _OfflineState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: softShadow(opacity: 0.06),
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(color: AppColors.chipBackground, shape: BoxShape.circle),
            child: const Icon(Icons.notifications_paused_rounded, color: AppColors.primary, size: 26),
          ),
          const SizedBox(height: 12),
          const Text(
            "You're offline",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          const Text(
            'Switch on availability above to start receiving nearby alerts.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 11.5, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
