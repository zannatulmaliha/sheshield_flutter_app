import 'package:flutter/material.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/user/presentation/providers/checkin_state.dart';

/// Shown while a countdown is already running: how long is left, plus the
/// "I'm safe" cancel button.
class CheckInRunningContent extends StatelessWidget {
  const CheckInRunningContent({
    super.key,
    required this.checkIn,
    required this.palette,
    required this.onImSafe,
  });

  final CheckInState checkIn;
  final AppPalette palette;
  final VoidCallback onImSafe;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final minutes = checkIn.remainingSeconds ~/ 60;
    final seconds = (checkIn.remainingSeconds % 60).toString().padLeft(2, '0');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.checkInAlreadyRunningTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.checkInAlreadyRunningBody('${minutes}m ${seconds}s'),
          textAlign: TextAlign.center,
          style: TextStyle(color: palette.textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: palette.success,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: onImSafe,
          child: Text(
            l10n.checkInImSafeCancel,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}
