import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/user/presentation/widgets/sos_step_buttons.dart';

/// Step 3 (spec §2): real-time audio/video consent. Never pre-checked: an
/// explicit Yes / No right before dispatch.
class SosConsentStep extends StatelessWidget {
  const SosConsentStep({
    super.key,
    required this.palette,
    required this.isSending,
    required this.onAnswer,
  });

  final AppPalette palette;
  final bool isSending;
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
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: palette.primary.withValues(alpha: 0.12),
          ),
          child: Icon(Icons.videocam_rounded, color: palette.primary, size: 32),
        ),
        const SizedBox(height: 18),
        Text(
          'Start audio/video recording?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
            color: palette.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Your trusted contacts are being alerted now. Recording is optional and '
          'can help document this emergency.',
          textAlign: TextAlign.center,
          style: TextStyle(color: palette.textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: SosOutlinedStepButton(
                label: 'No',
                textColor: palette.textPrimary,
                onPressed: isSending ? null : () => onAnswer(false),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SosFilledStepButton(
                color: palette.primary,
                onPressed: isSending ? null : () => onAnswer(true),
                child: isSending
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Yes'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
