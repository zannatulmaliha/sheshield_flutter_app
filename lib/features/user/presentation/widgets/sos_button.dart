import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/core/theme/app_palette.dart';
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
    final colors = resolvePalette(context, ref);
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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.sosStart,
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
                gradient: LinearGradient(
                  colors: colors.sosGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: colors.sosEnd.withValues(alpha: 0.45),
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

/// The three steps of the spec's §2 SOS lifecycle prelude:
/// confirm -> a cancelable 10s countdown, no penalty for backing out ->
/// a real-time AV-recording consent prompt -> only then does Trigger
/// actually fire.
enum _SosStep { confirm, countdown, consent }

const _kCountdownSeconds = 10;

class _SosConfirmSheet extends ConsumerStatefulWidget {
  const _SosConfirmSheet();

  @override
  ConsumerState<_SosConfirmSheet> createState() => _SosConfirmSheetState();
}

class _SosConfirmSheetState extends ConsumerState<_SosConfirmSheet> {
  _SosStep _step = _SosStep.confirm;
  int _secondsLeft = _kCountdownSeconds;
  Timer? _timer;
  bool _sending = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      _step = _SosStep.countdown;
      _secondsLeft = _kCountdownSeconds;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (_secondsLeft <= 1) {
        _timer?.cancel();
        setState(() => _step = _SosStep.consent);
        return;
      }
      setState(() => _secondsLeft -= 1);
    });
  }

  /// Cancelable, no penalty: just stops the timer and closes the sheet --
  /// nothing was ever sent, so there's nothing to undo server-side.
  void _cancelCountdown() {
    _timer?.cancel();
    Navigator.of(context).pop();
  }

  Future<void> _confirmConsent(bool consent) async {
    if (_sending) return;
    setState(() => _sending = true);

    final error = await ref.read(sosControllerProvider.notifier).send(avConsent: consent);
    if (!mounted) return;

    Navigator.of(context).pop();

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
      return;
    }
    const SosSentRoute().push(context);
  }

  @override
  Widget build(BuildContext context) {
    final colors = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
        decoration: BoxDecoration(
          color: colors.surface,
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
            switch (_step) {
              _SosStep.confirm => _ConfirmStep(colors: colors, l10n: l10n, onConfirm: _startCountdown),
              _SosStep.countdown => _CountdownStep(colors: colors, secondsLeft: _secondsLeft, onCancel: _cancelCountdown),
              _SosStep.consent => _ConsentStep(colors: colors, sending: _sending, onAnswer: _confirmConsent),
            },
          ],
        ),
      ),
    );
  }
}

class _ConfirmStep extends StatelessWidget {
  const _ConfirmStep({required this.colors, required this.l10n, required this.onConfirm});
  final AppPalette colors;
  final AppLocalizations l10n;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          alignment: Alignment.center,
          width: 64,
          height: 64,
          decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: colors.sosGradient)),
          child: const Icon(Icons.warning_rounded, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 18),
        Text(l10n.sendEmergencyAlert, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(l10n.sendEmergencyAlertBody, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
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
                child: Text(l10n.cancel, style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.sosEnd,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: onConfirm,
                child: Text(l10n.sendSos, style: const TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// The spec's §2 "10s COUNTDOWN (cancelable, no penalty)". Nothing has been
/// sent yet at this point -- canceling here simply closes the sheet.
class _CountdownStep extends StatelessWidget {
  const _CountdownStep({required this.colors, required this.secondsLeft, required this.onCancel});
  final AppPalette colors;
  final int secondsLeft;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 88,
              height: 88,
              child: TweenAnimationBuilder<double>(
                key: ValueKey(secondsLeft),
                tween: Tween(begin: 1, end: 0),
                duration: const Duration(seconds: 1),
                builder: (context, value, _) => CircularProgressIndicator(
                  value: value,
                  strokeWidth: 6,
                  backgroundColor: colors.chipBackground,
                  valueColor: AlwaysStoppedAnimation(colors.sosEnd),
                ),
              ),
            ),
            Text(
              '$secondsLeft',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: colors.textPrimary),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          'Sending SOS in $secondsLeft...',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: colors.textPrimary),
        ),
        const SizedBox(height: 8),
        Text(
          'Cancel now if this was a mistake -- nothing has been sent yet.',
          textAlign: TextAlign.center,
          style: TextStyle(color: colors.textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: colors.sosEnd),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: onCancel,
            child: Text('Cancel', style: TextStyle(color: colors.sosEnd, fontWeight: FontWeight.w800)),
          ),
        ),
      ],
    );
  }
}

/// The spec's §2 real-time AV consent prompt -- never pre-checked, always
/// an explicit Yes/No right before dispatch.
class _ConsentStep extends StatelessWidget {
  const _ConsentStep({required this.colors, required this.sending, required this.onAnswer});
  final AppPalette colors;
  final bool sending;
  final ValueChanged<bool> onAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          alignment: Alignment.center,
          width: 64,
          height: 64,
          decoration: BoxDecoration(shape: BoxShape.circle, color: colors.primary.withValues(alpha: 0.12)),
          child: Icon(Icons.videocam_rounded, color: colors.primary, size: 32),
        ),
        const SizedBox(height: 18),
        Text(
          'Start audio/video recording?',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: colors.textPrimary),
        ),
        const SizedBox(height: 8),
        Text(
          'Your trusted contacts are being alerted now. Recording is optional and can help document this emergency.',
          textAlign: TextAlign.center,
          style: TextStyle(color: colors.textSecondary, fontSize: 13),
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
                onPressed: sending ? null : () => onAnswer(false),
                child: Text('No', style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: sending ? null : () => onAnswer(true),
                child: sending
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Yes', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}