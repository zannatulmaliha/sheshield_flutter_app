import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sheshield/core/hooks/use_permission_statuses.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/utils/permission_extensions.dart';

/// What notification permission gates: the full-screen "SOS ALERT" alarm
/// shown when a trusted contact triggers one (the `sos_alarm_channel` in
/// push_service). It is one channel with one purpose, so there is no
/// per-category toggle: this screen shows whether it's allowed and hands
/// off to the OS settings (sound, vibration, priority) once it is.
class NotificationSettingsScreen extends HookConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context);
    final permissionStatuses = usePermissionStatuses([Permission.notification]);
    final isAllowed = permissionStatuses[Permission.notification].isAllowed;
    final accent = isAllowed ? palette.success : palette.warning;

    Future<void> requestOrOpenSettings() async {
      if (permissionStatuses[Permission.notification] ==
          PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      } else {
        await Permission.notification.request();
      }
      await permissionStatuses.refresh();
    }

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        title: Text(l10n.notificationSettings),
        backgroundColor: palette.background,
        foregroundColor: palette.textPrimary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: accent.withValues(alpha: 0.25)),
            ),
            child: Row(
              children: [
                Icon(
                  isAllowed
                      ? Icons.notifications_active_rounded
                      : Icons.notifications_off_rounded,
                  color: accent,
                  size: 30,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    isAllowed
                        ? 'SOS alerts from your trusted contacts will alarm this phone.'
                        : "SOS alerts from your trusted contacts won't alarm this phone "
                            'until this is allowed.',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: palette.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'What this permission is for',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14.5,
              color: palette.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "When a contact who's linked their SheShield account sends an SOS, this "
            'device gets a full-screen alarm -- the same as an incoming call -- even '
            'if the app is closed. It only ever fires for a real SOS.',
            style: TextStyle(color: palette.textSecondary, fontSize: 12.5, height: 1.4),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: palette.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: requestOrOpenSettings,
              child: Text(
                isAllowed ? 'Open notification settings' : 'Allow notifications',
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
