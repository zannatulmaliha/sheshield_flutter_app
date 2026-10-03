import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sheshield/core/hooks/use_permission_statuses.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/services/motion/motion_settings_screen.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/settings/presentation/widgets/app_permission_info.dart';
import 'package:sheshield/features/settings/presentation/widgets/discoverable_tile.dart';
import 'package:sheshield/features/settings/presentation/widgets/permission_tile.dart';

class PrivacyPermissionsScreen extends HookConsumerWidget {
  const PrivacyPermissionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context);
    final permissionStatuses = usePermissionStatuses([
      for (final info in appPermissions) info.permission,
    ]);

    Future<void> requestOrOpenSettings(Permission permission) async {
      if (permissionStatuses[permission] == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
        return;
      }
      await permission.request();
      await permissionStatuses.refresh();
    }

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        title: Text(l10n.privacyPermissions),
        backgroundColor: palette.background,
        foregroundColor: palette.textPrimary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Text(
            "What each permission is for, and whether it's currently allowed on this device.",
            style: TextStyle(color: palette.textSecondary, fontSize: 12.5),
          ),
          const SizedBox(height: 16),
          ListTile(
            tileColor: palette.surface,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            leading: Icon(Icons.directions_run_rounded, color: palette.primary),
            title: Text(
              'Movement protection',
              style: TextStyle(color: palette.textPrimary, fontWeight: FontWeight.w800),
            ),
            subtitle: Text(
              'Fall, sprint and struggle detection',
              style: TextStyle(color: palette.textSecondary, fontSize: 12),
            ),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const MotionSettingsScreen()),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: palette.surface,
              borderRadius: BorderRadius.circular(22),
              boxShadow: softShadow(opacity: 0.07),
            ),
            child: Column(
              children: [
                for (final (index, info) in appPermissions.indexed) ...[
                  PermissionTile(
                    info: info,
                    status: permissionStatuses[info.permission],
                    palette: palette,
                    onTap: () => requestOrOpenSettings(info.permission),
                  ),
                  if (index != appPermissions.length - 1)
                    Divider(
                      height: 1,
                      indent: 68,
                      endIndent: 16,
                      color: palette.chipBackground,
                    ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Mutual connections',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 13,
              color: palette.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "If someone you're already connected to sends an SOS, helpers who've also "
            'opted in can see that you know each other. Off by default -- turning it on '
            "doesn't share your identity with anyone who isn't already a mutual connection.",
            style: TextStyle(fontSize: 11.5, color: palette.textSecondary, height: 1.3),
          ),
          const SizedBox(height: 10),
          const DiscoverableTile(),
        ],
      ),
    );
  }
}
