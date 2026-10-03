import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/user/presentation/widgets/checkin_banner.dart';
import 'package:sheshield/features/user/presentation/widgets/contacts_preview.dart';
import 'package:sheshield/features/user/presentation/widgets/home_status_card.dart';
import 'package:sheshield/features/user/presentation/widgets/home_top_bar.dart';
import 'package:sheshield/features/user/presentation/widgets/quick_actions_grid.dart';
import 'package:sheshield/features/user/presentation/widgets/section_title.dart';
import 'package:sheshield/features/user/presentation/widgets/sos_button.dart';
import 'package:sheshield/shared/widgets/glass_card.dart';
import 'package:sheshield/shared/widgets/staggered_fade_in.dart';

/// User-mode Home: the SOS button, protection status, quick actions and a
/// trusted-contacts preview.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, required this.onOpenContacts});

  final VoidCallback onOpenContacts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
        children: [
          StaggeredFadeIn(
            children: [
              const HomeTopBar(),
              const SizedBox(height: 24),
              GlassCard(
                padding: const EdgeInsets.symmetric(vertical: 26),
                child: Column(
                  children: [
                    const SosButton(),
                    const SizedBox(height: 16),
                    Text(
                      l10n.tapForEmergencyAlert,
                      style: TextStyle(
                        color: palette.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const CheckInBanner(),
              const HomeStatusCard(),
              const SizedBox(height: 28),
              SectionTitle(title: l10n.quickActions),
              const SizedBox(height: 14),
              const QuickActionsGrid(),
              const SizedBox(height: 28),
              SectionTitle(
                title: l10n.trustedContacts,
                actionLabel: l10n.seeAll,
                onAction: onOpenContacts,
              ),
              const SizedBox(height: 14),
              ContactsPreview(onTap: onOpenContacts),
            ],
          ),
        ],
      ),
    );
  }
}
