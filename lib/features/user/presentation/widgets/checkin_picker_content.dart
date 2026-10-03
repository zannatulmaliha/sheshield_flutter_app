import 'package:flutter/material.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';

/// Pick how long the countdown should run, then start it.
class CheckInPickerContent extends StatelessWidget {
  const CheckInPickerContent({
    super.key,
    required this.selectedMinutes,
    required this.palette,
    required this.onMinutesSelected,
    required this.onStart,
  });

  static const _minuteOptions = [5, 15, 30, 60];

  final int selectedMinutes;
  final AppPalette palette;
  final ValueChanged<int> onMinutesSelected;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.checkInSheetTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.checkInSheetBody,
          textAlign: TextAlign.center,
          style: TextStyle(color: palette.textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 20),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final minutes in _minuteOptions)
              ChoiceChip(
                label: Text('$minutes min'),
                selected: selectedMinutes == minutes,
                onSelected: (_) => onMinutesSelected(minutes),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: selectedMinutes == minutes ? Colors.white : palette.textPrimary,
                ),
                selectedColor: AppTheme.accentPurple,
                backgroundColor: palette.chipBackground,
                showCheckmark: false,
              ),
          ],
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.accentPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: onStart,
          child: Text(
            l10n.checkInStartButton(selectedMinutes),
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }
}
