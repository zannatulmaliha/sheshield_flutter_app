import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_provider.dart';
import 'package:sheshield/features/settings/presentation/widgets/language_picker_sheet.dart';
import 'package:sheshield/features/user/presentation/screens/profile_edit_sheets.dart';
import 'package:sheshield/features/user/presentation/widgets/emergency_info_card.dart';
import 'package:sheshield/features/user/presentation/widgets/profile_header.dart';
import 'package:sheshield/features/user/presentation/widgets/profile_settings_list.dart';
import 'package:sheshield/shared/widgets/staggered_fade_in.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(authStateProvider).valueOrNull;

    if (user == null) return const SizedBox.shrink();

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
        children: [
          StaggeredFadeIn(
            children: [
              Text(l10n.profileTitle, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 20),
              ProfileHeader(
                palette: palette,
                user: user,
                onEditName: () => showEditNameSheet(context, ref, user),
              ),
              const SizedBox(height: 22),
              EmergencyInfoCard(
                palette: palette,
                user: user,
                onEditAddress: () => showEditAddressSheet(context, ref, user),
              ),
              const SizedBox(height: 26),
              Text(
                l10n.settingsTitle,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: palette.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              ProfileSettingsList(
                palette: palette,
                onOpenLanguage: () => showLanguagePickerSheet(context),
                onLogOut: () => ref.read(authControllerProvider.notifier).signOut(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
