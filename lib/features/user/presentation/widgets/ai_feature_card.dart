import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';

/// One AI Guardian feature: icon, title, explanation and an on/off switch.
/// Giving [onTap] makes the whole card tappable (the fake call card opens
/// its scheduler).
class AiFeatureCard extends StatelessWidget {
  const AiFeatureCard({
    super.key,
    required this.palette,
    required this.icon,
    required this.title,
    required this.description,
    required this.isEnabled,
    required this.onChanged,
    this.onTap,
    this.footer,
  });

  final AppPalette palette;
  final IconData icon;
  final String title;
  final String description;
  final bool isEnabled;
  final ValueChanged<bool> onChanged;
  final VoidCallback? onTap;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final accent = isEnabled ? palette.primary : palette.textSecondary;

    final card = Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: softShadow(opacity: 0.07),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: accent, size: 21),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                    color: palette.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: TextStyle(
                    color: palette.textSecondary,
                    fontSize: 11.5,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (footer != null) footer!,
              ],
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: isEnabled,
            activeThumbColor: Colors.white,
            activeTrackColor: palette.primary,
            onChanged: onChanged,
          ),
        ],
      ),
    );

    if (onTap == null) return card;
    return InkWell(borderRadius: BorderRadius.circular(22), onTap: onTap, child: card);
  }
}
