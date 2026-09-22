import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/sos/presentation/providers/sos_provider.dart';

/// Large pulsing SOS button. Tapping opens a confirmation sheet before
/// the emergency alert is sent.
class SosButton extends ConsumerStatefulWidget {
  const SosButton({super.key, this.size = 132});

  final double size;

  @override
  ConsumerState<SosButton> createState() => _SosButtonState();
}

class _SosButtonState extends ConsumerState<SosButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _handleTap() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const _SosConfirmSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;

    return GestureDetector(
      onTap: _handleTap,
      child: SizedBox(
        width: size * 1.7,
        height: size * 1.7,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: List.generate(2, (i) {
                    final progress =
                        (_pulseController.value + (i * 0.5)) % 1.0;

                    return Opacity(
                      opacity: (1 - progress) * 0.35,
                      child: Container(
                        width: size + (size * 0.7 * progress),
                        height: size + (size * 0.7 * progress),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.sosStart,
                        ),
                      ),
                    );
                  }),
                );
              },
            ),

            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: AppColors.sosGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.sosEnd.withValues(alpha: 0.45),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  ),
                ],
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shield_moon_rounded,
                    color: Colors.white,
                    size: size * 0.30,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'SOS',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: size * 0.18,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SosConfirmSheet extends ConsumerWidget {
  const _SosConfirmSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sosState = ref.watch(sosControllerProvider);
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: softShadow(opacity: 0.18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 42,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Container(
              alignment: Alignment.center,
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: AppColors.sosGradient,
                ),
              ),
              child: const Icon(
                Icons.warning_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              l10n.sendEmergencyAlert,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 8),

            Text(
              l10n.sendEmergencyAlertBody,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      side: const BorderSide(
                        color: Color(0xFFE3DEF5),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: sosState.isLoading
                        ? null
                        : () => Navigator.of(context).pop(),
                    child: Text(
                      l10n.cancel,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.sosEnd,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                          AppColors.sosEnd.withValues(alpha: 0.6),
                      disabledForegroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: sosState.isLoading
                        ? null
                        : () async {
                            final error = await ref
                                .read(sosControllerProvider.notifier)
                                .send();

                            if (!context.mounted) return;

                            Navigator.of(context).pop();

                            if (error != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(error),
                                ),
                              );
                              return;
                            }

                            Navigator.of(context).push(
                              PageRouteBuilder(
                                opaque: false,
                                barrierColor: Colors.black87,
                                pageBuilder: (_, __, ___) =>
                                    const _SosActivatedOverlay(),
                              ),
                            );
                          },
                    child: sosState.isLoading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            l10n.sendSos,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SosActivatedOverlay extends ConsumerWidget {
  const _SosActivatedOverlay();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alert = ref.watch(sosControllerProvider).valueOrNull;
    final sentCount = alert?.sentCount ?? 0;
    final total = alert?.deliveries.length ?? 0;
    final failedCount = alert?.failedCount ?? 0;
    final l10n = AppLocalizations.of(context);

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
              Text(
                l10n.sosAlertSentTitle,
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              Text(
                total == 0
                    ? l10n.sosNotifiedFallback
                    : failedCount == 0
                        ? l10n.sosNotifiedAll(total)
                        : l10n.sosNotifiedPartial(sentCount, total, failedCount),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
              ),
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
                  onPressed: () {
                    // No cancel endpoint on the backend -- contacts are
                    // already texted by the time this alert exists.
                    // This only clears the local "sent" state.
                    ref.read(sosControllerProvider.notifier).dismiss();
                    Navigator.of(context).pop();
                  },
                  child: Text(l10n.imSafe, style: const TextStyle(fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}