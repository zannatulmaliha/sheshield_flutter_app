import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import '../providers/checkin_provider.dart';

/// Shown on the home screen only while a check-in countdown is running or
/// has just auto-fired -- invisible (SizedBox.shrink) the rest of the time.
class CheckInBanner extends ConsumerWidget {
  const CheckInBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkIn = ref.watch(checkInControllerProvider);

    switch (checkIn.status) {
      case CheckInStatus.idle:
        return const SizedBox.shrink();
      case CheckInStatus.running:
        return _RunningCard(checkIn: checkIn);
      case CheckInStatus.sosSent:
        return const _SosSentCard();
    }
  }
}

class _RunningCard extends ConsumerWidget {
  const _RunningCard({required this.checkIn});
  final CheckInState checkIn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context)!;
    final minutes = checkIn.remainingSeconds ~/ 60;
    final seconds = checkIn.remainingSeconds % 60;
    final time = '${minutes}m ${seconds.toString().padLeft(2, '0')}s';

    return Container(
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.only(bottom: 28),
      decoration: BoxDecoration(
        color: AppTheme.accentPurple.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppTheme.accentPurple.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          const Icon(Icons.timer_outlined, color: AppTheme.accentPurple, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.checkInBannerCountdown(time),
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: colors.textPrimary),
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: checkIn.progress,
                    minHeight: 5,
                    backgroundColor: AppTheme.accentPurple.withValues(alpha: 0.15),
                    valueColor: const AlwaysStoppedAnimation(AppTheme.accentPurple),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.success,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => ref.read(checkInControllerProvider.notifier).checkIn(),
            child: Text(l10n.checkInImSafe, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5)),
          ),
        ],
      ),
    );
  }
}

class _SosSentCard extends ConsumerWidget {
  const _SosSentCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.only(bottom: 28),
      decoration: BoxDecoration(
        color: colors.sosStart.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colors.sosStart.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_rounded, color: colors.sosStart, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              l10n.checkInSosSentMessage,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: colors.textPrimary),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.close_rounded, color: colors.textSecondary),
            onPressed: () => ref.read(checkInControllerProvider.notifier).dismiss(),
          ),
        ],
      ),
    );
  }
}
