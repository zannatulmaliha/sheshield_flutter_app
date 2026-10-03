import 'package:flutter/material.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';

/// Row of labeled color dots explaining the heat map's three tiers.
class DangerZoneLegend extends StatelessWidget {
  const DangerZoneLegend({super.key, required this.palette, required this.l10n});

  final AppPalette palette;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final entries = [
      (palette.success, l10n.dangerZoneLegendLow),
      (palette.warning, l10n.dangerZoneLegendMedium),
      (palette.sosEnd, l10n.dangerZoneLegendHigh),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        children: [
          for (final (color, label) in entries)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: palette.textSecondary,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
