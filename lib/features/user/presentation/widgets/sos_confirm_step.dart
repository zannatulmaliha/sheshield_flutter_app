import 'package:flutter/material.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/user/presentation/widgets/sos_step_buttons.dart';

/// Step 1: "Send emergency alert?" Nothing is sent yet.
class SosConfirmStep extends StatelessWidget {
  const SosConfirmStep({super.key, required this.palette, required this.onConfirm});

  final AppPalette palette;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          alignment: Alignment.center,
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: palette.sosGradient),
          ),
          child: const Icon(Icons.warning_rounded, color: Colors.white, size: 32),
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
              child: SosOutlinedStepButton(
                label: l10n.cancel,
                textColor: palette.textPrimary,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SosFilledStepButton(
                color: palette.sosEnd,
                onPressed: onConfirm,
                child: Text(l10n.sendSos),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
