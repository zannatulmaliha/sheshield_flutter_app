import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Large pulsing SOS button. Tapping opens a confirmation sheet before
/// the emergency alert is "sent" (simulated for this UI).
class SosButton extends StatefulWidget {
  const SosButton({super.key, this.size = 132});

  final double size;

  @override
  State<SosButton> createState() => _SosButtonState();
}

class _SosButtonState extends State<SosButton> with SingleTickerProviderStateMixin {
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
                    final progress = (_pulseController.value + (i * 0.5)) % 1.0;
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
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shield_moon_rounded, color: Colors.white, size: size * 0.30),
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

class _SosConfirmSheet extends StatelessWidget {
  const _SosConfirmSheet();

  @override
  Widget build(BuildContext context) {
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
                gradient: LinearGradient(colors: AppColors.sosGradient),
              ),
              child: const Icon(Icons.warning_rounded, color: Colors.white, size: 32),
            ),
            const SizedBox(height: 18),
            Text(
              'Send emergency alert?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Your live location and an SOS message will be sent to all your trusted contacts immediately.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Color(0xFFE3DEF5)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.sosEnd,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          barrierColor: Colors.black87,
                          pageBuilder: (_, _, _) => const _SosActivatedOverlay(),
                        ),
                      );
                    },
                    child: const Text('Send SOS', style: TextStyle(fontWeight: FontWeight.w800)),
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

class _SosActivatedOverlay extends StatelessWidget {
  const _SosActivatedOverlay();

  @override
  Widget build(BuildContext context) {
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
              const Text(
                'Your trusted contacts have been notified with your live location.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
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
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel Alert', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
