import 'dart:async';

import 'package:flutter/material.dart';
import '../state/game_scope.dart';
import '../theme/app_theme.dart';
import 'level_up_overlay.dart';
import 'xp_toast.dart';

/// Large pulsing SOS button. Tapping immediately starts a 5-second
/// countdown that auto-sends the alert unless the user cancels it.
class SosButton extends StatefulWidget {
  const SosButton({super.key, this.size = 168});

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
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder: (_, _, _) => const _SosCountdownOverlay(),
      ),
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

/// Full-screen overlay that counts down from 5 and auto-sends the SOS
/// alert unless the user taps Cancel before it reaches zero.
class _SosCountdownOverlay extends StatefulWidget {
  const _SosCountdownOverlay();

  @override
  State<_SosCountdownOverlay> createState() => _SosCountdownOverlayState();
}

class _SosCountdownOverlayState extends State<_SosCountdownOverlay> {
  static const int _startSeconds = 5;
  int _secondsLeft = _startSeconds;
  bool _sent = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
  }

  void _tick(Timer timer) {
    if (_secondsLeft <= 1) {
      timer.cancel();
      setState(() {
        _secondsLeft = 0;
        _sent = true;
      });
      _awardXp();
      return;
    }
    setState(() => _secondsLeft--);
  }

  void _awardXp() {
    final game = GameScope.read(context);
    final leveledUp = game.addXp(30);
    final newBadge = game.unlockBadge('ninja_reflexes');
    Future.delayed(Duration(milliseconds: leveledUp ? 900 : 400), () {
      if (!mounted) return;
      if (leveledUp) {
        showLevelUpCelebration(context, level: game.level, tierTitle: game.tierTitle);
      } else if (newBadge) {
        showXpToast(context, 30, label: 'Ninja Reflexes unlocked');
      } else {
        showXpToast(context, 30);
      }
    });
  }

  void _cancel() {
    _timer?.cancel();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: _sent ? _SentContent(onDismiss: () => Navigator.of(context).pop()) : _CountdownContent(secondsLeft: _secondsLeft, onCancel: _cancel),
        ),
      ),
    );
  }
}

class _CountdownContent extends StatelessWidget {
  const _CountdownContent({required this.secondsLeft, required this.onCancel});

  final int secondsLeft;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final progress = secondsLeft / _SosCountdownOverlayState._startSeconds;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 140,
          height: 140,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 140,
                height: 140,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 1, end: progress),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.linear,
                  builder: (context, value, _) => CircularProgressIndicator(
                    value: value,
                    strokeWidth: 7,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
              ),
              Text(
                '$secondsLeft',
                style: const TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        const Text(
          'Sending SOS alert...',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        const Text(
          'Your live location will be shared with your trusted contacts automatically.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 13.5, height: 1.4),
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
            onPressed: onCancel,
            child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ),
      ],
    );
  }
}

class _SentContent extends StatelessWidget {
  const _SentContent({required this.onDismiss});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            onPressed: onDismiss,
            child: const Text('Done', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ),
      ],
    );
  }
}
