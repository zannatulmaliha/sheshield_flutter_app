import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_provider.dart';
import 'package:sheshield/features/contacts/presentation/providers/contacts_provider.dart';
import 'package:sheshield/features/user/presentation/widgets/section_title.dart';
import 'package:sheshield/features/user/presentation/widgets/sos_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onOpenContacts,
  });

  final VoidCallback onOpenContacts;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
        children: [
          const _TopBar(),

          const SizedBox(height: 24),

          Center(
            child: Column(
              children: [
                const SosButton(),
                const SizedBox(height: 14),
                Text(
                  l10n.tapForEmergencyAlert,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          const _StatusCard(),

          const SizedBox(height: 28),

          SectionTitle(
            title: l10n.quickActions,
          ),

          const SizedBox(height: 14),

          const _QuickActionsGrid(),

          const SizedBox(height: 28),

          SectionTitle(
            title: l10n.trustedContacts,
            actionLabel: l10n.seeAll,
            onAction: onOpenContacts,
          ),

          const SizedBox(height: 14),

          _ContactsPreview(
            onTap: onOpenContacts,
          ),
        ],
      ),
    );
  }
}

class _TopBar extends ConsumerWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(authStateProvider).valueOrNull;
    final firstName = (user?.name ?? '').trim().split(RegExp(r'\s+')).first;

    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: AppColors.heroGradient,
            ),
            boxShadow: softShadow(
              color: AppColors.primary,
              opacity: 0.25,
            ),
          ),
          child: const Icon(
            Icons.shield_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.greetingHi(firstName.isEmpty ? l10n.appName : firstName),
                style: Theme.of(context).textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                // The tagline is gender-aware: the ARB entry picks a
                // female / male / other variant via ICU `select`, so a
                // helper who isn't a woman doesn't get a message
                // written for the person he's protecting.
                l10n.homeTagline(user?.gender.name ?? 'other'),
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        _IconBadge(
          icon: Icons.notifications_none_rounded,
          onTap: () {},
        ),
      ],
    );
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: softShadow(
            opacity: 0.10,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(
                icon,
                color: AppColors.textPrimary,
                size: 22,
              ),
            ),

            Positioned(
              top: 11,
              right: 11,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends ConsumerWidget {
  const _StatusCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final contactCount =
        ref.watch(contactsControllerProvider).valueOrNull?.length ?? 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.heroGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: softShadow(
          color: AppColors.primary,
          opacity: 0.28,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.verified_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      l10n.youAreProtected,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  l10n.liveLocationSharingCount(contactCount),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.location_on_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();

  static const _colors = [
    Color(0xFFFF8FA3),
    Color(0xFF3F5EFB),
    Color(0xFFFFA94D),
    Color(0xFF2FC28E),
  ];

  static const _icons = [
    Icons.call_rounded,
    Icons.share_location_rounded,
    Icons.videocam_rounded,
    Icons.alt_route_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // Labels can't live in the static const tuple list above --
    // l10n getters aren't compile-time constants -- so they're
    // looked up here and zipped with the icon/color at build time.
    final labels = [
      l10n.fakeCall,
      l10n.shareLocation,
      l10n.recordEvidence,
      l10n.safeRoute,
    ];
    final actions = List.generate(
      _icons.length,
      (i) => (_icons[i], labels[i], _colors[i]),
    );

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      childAspectRatio: 2.5,
      children: actions.map((a) {
        final (icon, label, color) = a;

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: softShadow(
              opacity: 0.08,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.14),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 19,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _ContactsPreview extends ConsumerWidget {
  const _ContactsPreview({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final l10n = AppLocalizations.of(context);
    final contacts =
        ref.watch(contactsControllerProvider).valueOrNull ?? const [];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: softShadow(
            opacity: 0.08,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 84,
              height: 40,
              child: Stack(
                children: List.generate(
                  contacts.length.clamp(0, 3),
                  (i) {
                    final c = contacts[i];

                    const palette = [
                      Color(0xFFFF8FA3),
                      Color(0xFF7B2FF7),
                      Color(0xFF3F5EFB),
                    ];

                    return Positioned(
                      left: i * 24.0,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor:
                              palette[i % palette.length],
                          child: Text(
                            c.initials,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Expanded(
              child: Text(
                contacts.isEmpty
                    ? l10n.addContactToEnableSos
                    : l10n.contactsWillBeAlerted(contacts.length),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}