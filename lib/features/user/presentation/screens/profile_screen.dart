import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_provider.dart';
import 'package:sheshield/features/gamification/presentation/widgets/badge_grid.dart';
import 'package:sheshield/features/settings/presentation/widgets/language_picker_sheet.dart';
import 'package:sheshield/features/sos/presentation/screens/sos_alarm_screen.dart';
import 'package:sheshield/shared/entities/app_user.dart';
import 'package:sheshield/shared/entities/user_type.dart';
import 'profile_edit_sheets.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final AsyncValue<AppUser?> authState = ref.watch(authStateProvider);
    final AppUser? user = authState.valueOrNull;

    if (user == null) {
      return const SizedBox.shrink();
    }

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
        children: [
          Text(l10n.profileTitle, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 20),
          _ProfileHeader(
            user: user,
            onEditName: () => showEditNameSheet(context, ref, user),
          ),
          const SizedBox(height: 22),
          _EmergencyInfoCard(
            user: user,
            onEditAddress: () => showEditAddressSheet(context, ref, user),
          ),
          const SizedBox(height: 26),
          const Text(
            'Badges',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 12),
          const BadgeGrid(),
          const SizedBox(height: 26),
          Text(
            l10n.settingsTitle,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 12),
          _SettingsList(
            onOpenLanguage: () => showLanguagePickerSheet(context),
            onLogOut: () => ref.read(authControllerProvider.notifier).signOut(),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user, required this.onEditName});

  final AppUser user;
  final VoidCallback onEditName;

  String get _initials {
    final List<String> parts = user.name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.heroGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: softShadow(color: AppColors.primary, opacity: 0.28),
      ),
      child: Row(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.2),
              border: Border.all(color: Colors.white, width: 2.5),
            ),
            child: Center(
              child: Text(
                _initials,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onEditName,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
              child: const Icon(Icons.edit_rounded, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmergencyInfoCard extends StatelessWidget {
  const _EmergencyInfoCard({required this.user, required this.onEditAddress});

  final AppUser user;
  final VoidCallback onEditAddress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bool hasAddress = user.address != null && user.address!.trim().isNotEmpty;
    final String addressLabel = hasAddress ? user.address! : l10n.tapToAdd;

    final String roleLabel = switch (user.userType) {
      UserType.user => l10n.userTypeUser,
      UserType.helper => l10n.userTypeHelper,
      UserType.userHelper => l10n.userTypeUserHelper,
    };

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: softShadow(opacity: 0.07),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.medical_information_rounded, color: AppColors.secondary, size: 20),
              const SizedBox(width: 8),
              Text(
                l10n.emergencyInfo,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _InfoTile(label: l10n.phone, value: '${user.countryCode} ${user.phone}')),
              Expanded(child: _InfoTile(label: l10n.role, value: roleLabel)),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onEditAddress,
            child: _InfoTile(label: l10n.homeAddress, value: addressLabel),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.w600)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13.5, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _SettingsList extends StatelessWidget {
  const _SettingsList({required this.onOpenLanguage, required this.onLogOut});

  final VoidCallback onOpenLanguage;
  final VoidCallback onLogOut;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // isDestructive drives the red styling explicitly, instead of
    // comparing against a hardcoded English label -- that comparison
    // would silently stop matching as soon as the label is localized.
    final List<(IconData, String, VoidCallback, bool)> items = <(IconData, String, VoidCallback, bool)>[
      // Debug-only: lets the alarm sound/screen be checked on this device
      // without needing the FCM push pipeline (which needs a Firebase
      // project) to actually be wired up yet. Remove once that's live and
      // testing an incoming push end-to-end is possible instead.
      if (kDebugMode)
        (Icons.alarm_rounded, 'Test SOS Alarm (debug)', () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const SosAlarmScreen(
                  senderName: 'Test contact',
                  latitude: 23.8103,
                  longitude: 90.4125,
                ),
                fullscreenDialog: true,
              ),
            ), false),
      (Icons.language_rounded, l10n.language, onOpenLanguage, false),
      (Icons.lock_outline_rounded, l10n.privacyPermissions, () {}, false),
      (Icons.notifications_none_rounded, l10n.notificationSettings, () {}, false),
      (Icons.dark_mode_outlined, l10n.appTheme, () {}, false),
      (Icons.help_outline_rounded, l10n.helpSupport, () {}, false),
      (Icons.logout_rounded, l10n.logOut, onLogOut, true),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: softShadow(opacity: 0.07),
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(22),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: List<Widget>.generate(items.length, (int i) {
            final (IconData icon, String label, VoidCallback onTap, bool isDestructive) = items[i];
            final bool isLast = i == items.length - 1;
            return Column(
              children: [
                ListTile(
                  onTap: onTap,
                  leading: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: (isDestructive ? AppColors.sosEnd : AppColors.primary).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 18, color: isDestructive ? AppColors.sosEnd : AppColors.primary),
                  ),
                  title: Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                      color: isDestructive ? AppColors.sosEnd : AppColors.textPrimary,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
                ),
                if (!isLast) const Divider(height: 1, indent: 68, endIndent: 16, color: Color(0xFFF0EEF7)),
              ],
            );
          }),
        ),
      ),
    );
  }
}