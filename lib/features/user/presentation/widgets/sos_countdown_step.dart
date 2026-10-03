import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/user/presentation/widgets/sos_step_buttons.dart';

/// Step 2 (spec §2): a cancelable 10s countdown, no penalty. Nothing has
/// been sent yet, so cancelling just closes the sheet.
class SosCountdownStep extends StatelessWidget {
  const SosCountdownStep({
    super.key,
    required this.palette,
    required this.secondsLeft,
    required this.onCancel,
  });

  final AppPalette palette;
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
                  backgroundColor: palette.chipBackground,
                  valueColor: AlwaysStoppedAnimation(palette.sosEnd),
                ),
              ),
            ),
            Text(
              '$secondsLeft',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: palette.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          'Sending SOS in $secondsLeft...',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 17,
            color: palette.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Cancel now if this was a mistake -- nothing has been sent yet.',
          textAlign: TextAlign.center,
          style: TextStyle(color: palette.textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 24),
        SosOutlinedStepButton(
          label: 'Cancel',
          textColor: palette.sosEnd,
          borderColor: palette.sosEnd,
          onPressed: onCancel,
        ),
      ],
    );
  }
}
