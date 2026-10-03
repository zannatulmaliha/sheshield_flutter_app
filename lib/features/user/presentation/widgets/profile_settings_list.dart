import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/settings/presentation/screens/help_support_screen.dart';
import 'package:sheshield/features/settings/presentation/screens/notification_settings_screen.dart';
import 'package:sheshield/features/settings/presentation/screens/privacy_permissions_screen.dart';
import 'package:sheshield/features/settings/presentation/widgets/theme_mode_picker_sheet.dart';
import 'package:sheshield/features/sos/presentation/screens/sos_alarm_screen.dart';
import 'package:sheshield/features/user/presentation/widgets/profile_settings_tile.dart';

void _push(BuildContext context, Widget screen) =>
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => screen));

class ProfileSettingsList extends StatelessWidget {
  const ProfileSettingsList({
    super.key,
    required this.palette,
    required this.onOpenLanguage,
    required this.onLogOut,
  });

  final AppPalette palette;
  final VoidCallback onOpenLanguage;
  final VoidCallback onLogOut;

  List<ProfileSettingsItem> _items(BuildContext context, AppLocalizations l10n) => [
        // Debug-only: lets the alarm sound/screen be checked without the FCM
        // push pipeline. Remove once end-to-end push testing is possible.
        if (kDebugMode)
          ProfileSettingsItem(
            icon: Icons.alarm_rounded,
            label: 'Test SOS Alarm (debug)',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const SosAlarmScreen(
                  senderName: 'Test contact',
                  latitude: 23.8103,
                  longitude: 90.4125,
                ),
                fullscreenDialog: true,
              ),
            ),
          ),
        ProfileSettingsItem(
          icon: Icons.language_rounded,
          label: l10n.language,
          onTap: onOpenLanguage,
        ),
        ProfileSettingsItem(
          icon: Icons.lock_outline_rounded,
          label: l10n.privacyPermissions,
          onTap: () => _push(context, const PrivacyPermissionsScreen()),
        ),
        ProfileSettingsItem(
          icon: Icons.notifications_none_rounded,
          label: l10n.notificationSettings,
          onTap: () => _push(context, const NotificationSettingsScreen()),
        ),
        ProfileSettingsItem(
          icon: Icons.dark_mode_outlined,
          label: l10n.appTheme,
          onTap: () => showThemeModePickerSheet(context),
        ),
        ProfileSettingsItem(
          icon: Icons.help_outline_rounded,
          label: l10n.helpSupport,
          onTap: () => _push(context, const HelpSupportScreen()),
        ),
        ProfileSettingsItem(
          icon: Icons.logout_rounded,
          label: l10n.logOut,
          onTap: onLogOut,
          isDestructive: true,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final items = _items(context, AppLocalizations.of(context));

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: softShadow(opacity: 0.07),
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(22),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            for (final (index, item) in items.indexed) ...[
              ProfileSettingsTile(item: item, palette: palette),
              if (index != items.length - 1)
                Divider(height: 1, indent: 68, endIndent: 16, color: palette.chipBackground),
            ],
          ],
        ),
      ),
    );
  }
}
