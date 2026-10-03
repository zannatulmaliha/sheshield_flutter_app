import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';

/// One row of the settings card. [isDestructive] drives the red styling
/// explicitly, rather than comparing against an English label that would
/// silently stop matching once the label is localized.
class ProfileSettingsItem {
  const ProfileSettingsItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;
}

class ProfileSettingsTile extends StatelessWidget {
  const ProfileSettingsTile({super.key, required this.item, required this.palette});

  final ProfileSettingsItem item;
  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    final accent = item.isDestructive ? palette.sosEnd : palette.primary;

    return ListTile(
      onTap: item.onTap,
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(item.icon, size: 18, color: accent),
      ),
      title: Text(
        item.label,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13.5,
          color: item.isDestructive ? palette.sosEnd : palette.textPrimary,
        ),
      ),
      trailing: Icon(Icons.chevron_right_rounded, color: palette.textSecondary),
    );
  }
}
