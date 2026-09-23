import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';

/// The runtime permissions SheShield actually asks for, and why -- so a
/// denial can be understood (and fixed, via the OS settings deep link)
/// instead of just silently breaking a feature. Order matches how central
/// each is to the app's core purpose.
const _permissions = <(Permission, IconData, String, String)>[
  (
    Permission.locationWhenInUse,
    Icons.location_on_rounded,
    'Location',
    'Needed to send your live location with an SOS alert and to show nearby helpers where you are.',
  ),
  (
    Permission.sms,
    Icons.sms_rounded,
    'SMS',
    "Lets the app text your trusted contacts directly from your own phone number when you press SOS.",
  ),
  (
    Permission.camera,
    Icons.videocam_rounded,
    'Camera & microphone',
    'Needed to record evidence video from the Quick Actions panel.',
  ),
  (
    Permission.notification,
    Icons.notifications_active_rounded,
    'Notifications',
    "Needed to alarm your phone the instant a trusted contact sends an SOS.",
  ),
];

class PrivacyPermissionsScreen extends ConsumerStatefulWidget {
  const PrivacyPermissionsScreen({super.key});

  @override
  ConsumerState<PrivacyPermissionsScreen> createState() => _PrivacyPermissionsScreenState();
}

class _PrivacyPermissionsScreenState extends ConsumerState<PrivacyPermissionsScreen> with WidgetsBindingObserver {
  Map<Permission, PermissionStatus> _statuses = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Coming back from the OS settings screen (after tapping "Open Settings")
  // resumes this app -- re-check statuses so a just-granted permission
  // shows up without the person needing to back out and re-enter.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refresh();
  }

  Future<void> _refresh() async {
    final statuses = <Permission, PermissionStatus>{};
    for (final (permission, _, _, _) in _permissions) {
      statuses[permission] = await permission.status;
    }
    if (mounted) setState(() => _statuses = statuses);
  }

  Future<void> _onTap(Permission permission) async {
    final status = _statuses[permission];
    if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
      return;
    }
    await permission.request();
    await _refresh();
  }

  String _statusLabel(PermissionStatus? status) => switch (status) {
        PermissionStatus.granted || PermissionStatus.limited => 'Allowed',
        PermissionStatus.permanentlyDenied => 'Denied — tap to open settings',
        _ => 'Not allowed — tap to allow',
      };

  @override
  Widget build(BuildContext context) {
    final colors = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(l10n.privacyPermissions),
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Text(
            'What each permission is for, and whether it\'s currently allowed on this device.',
            style: TextStyle(color: colors.textSecondary, fontSize: 12.5),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(22),
              boxShadow: softShadow(opacity: 0.07),
            ),
            child: Column(
              children: List.generate(_permissions.length, (i) {
                final (permission, icon, title, why) = _permissions[i];
                final status = _statuses[permission];
                final granted = status == PermissionStatus.granted || status == PermissionStatus.limited;
                final isLast = i == _permissions.length - 1;
                return Column(
                  children: [
                    ListTile(
                      onTap: () => _onTap(permission),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: (granted ? colors.success : colors.warning).withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, size: 19, color: granted ? colors.success : colors.warning),
                      ),
                      title: Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5, color: colors.textPrimary)),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(why, style: TextStyle(fontSize: 11.5, color: colors.textSecondary, height: 1.3)),
                      ),
                      trailing: Text(
                        _statusLabel(status),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: granted ? colors.success : colors.textSecondary,
                        ),
                      ),
                      isThreeLine: true,
                    ),
                    if (!isLast) Divider(height: 1, indent: 68, endIndent: 16, color: colors.chipBackground),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
