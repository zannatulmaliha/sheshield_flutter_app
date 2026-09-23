import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';

/// What notification permission actually gates: the full-screen "SOS ALERT"
/// alarm PushService shows when a trusted contact triggers one (see
/// core/services/push_service.dart's `sos_alarm_channel`). There's no
/// per-category toggle to expose here yet -- it's one channel, one purpose
/// -- so this screen's job is just: show whether it's allowed, and hand off
/// to the OS's own notification settings (sound, vibration, priority) once
/// it is.
class NotificationSettingsScreen extends ConsumerStatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  ConsumerState<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends ConsumerState<NotificationSettingsScreen> with WidgetsBindingObserver {
  PermissionStatus? _status;

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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refresh();
  }

  Future<void> _refresh() async {
    final status = await Permission.notification.status;
    if (mounted) setState(() => _status = status);
  }

  Future<void> _primaryAction() async {
    if (_status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    } else {
      await Permission.notification.request();
    }
    await _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final colors = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context)!;
    final granted = _status == PermissionStatus.granted || _status == PermissionStatus.limited;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(l10n.notificationSettings),
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: (granted ? colors.success : colors.warning).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: (granted ? colors.success : colors.warning).withValues(alpha: 0.25)),
            ),
            child: Row(
              children: [
                Icon(
                  granted ? Icons.notifications_active_rounded : Icons.notifications_off_rounded,
                  color: granted ? colors.success : colors.warning,
                  size: 30,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    granted
                        ? "SOS alerts from your trusted contacts will alarm this phone."
                        : "SOS alerts from your trusted contacts won't alarm this phone until this is allowed.",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: colors.textPrimary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'What this permission is for',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: colors.textPrimary),
          ),
          const SizedBox(height: 8),
          Text(
            "When a contact who's linked their SheShield account sends an SOS, this device gets a full-screen alarm "
            "-- the same as an incoming call -- even if the app is closed. It only ever fires for a real SOS.",
            style: TextStyle(color: colors.textSecondary, fontSize: 12.5, height: 1.4),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: _primaryAction,
              child: Text(
                granted ? 'Open notification settings' : 'Allow notifications',
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
