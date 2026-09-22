import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/sos/presentation/providers/sos_provider.dart';

/// Full-screen "SOS Alert Sent" confirmation. Pushed as a transparent
/// overlay route (see SosSentRoute in app_router.dart) right after a
/// successful send, so it still reads as a modal floating over Home.
class SosActivatedView extends ConsumerWidget {
  const SosActivatedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alert = ref.watch(sosControllerProvider).valueOrNull;
    final sentCount = alert?.sentCount ?? 0;
    final total = alert?.deliveries.length ?? 0;
    final failedCount = alert?.failedCount ?? 0;

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: AppColors.sosGradient),
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
                total == 0
                    ? 'Your trusted contacts have been notified with your live location.'
                    : failedCount == 0
                        ? 'Notified all $total trusted contact${total == 1 ? "" : "s"} with your live location.'
                        : 'Notified $sentCount of $total contacts. $failedCount could not be reached -- try calling them directly.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
              ),
              if (alert?.shareUrl != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.podcasts_rounded, color: Colors.white, size: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'They can watch your live location and hear an alarm at the link in the text.',
                          style: const TextStyle(color: Colors.white70, fontSize: 12.5, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.sosEnd,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () async {
                    await ref.read(sosControllerProvider.notifier).markSafe();
                    if (context.mounted) context.pop();
                  },
                  child: const Text("I'm Safe", style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
