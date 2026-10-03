import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_provider.dart';

/// Logo, greeting, gender-aware tagline, and the notifications bell.
class HomeTopBar extends ConsumerWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
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
            gradient: LinearGradient(colors: palette.heroGradient),
            boxShadow: softShadow(color: palette.primary, opacity: 0.25),
          ),
          child: const Icon(Icons.shield_rounded, color: Colors.white, size: 24),
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
                // The tagline is gender-aware: the ARB entry picks a female /
                // male / other variant via ICU `select`, so a helper who
                // isn't a woman doesn't get a message written for the person
                // he's protecting.
                l10n.homeTagline(user?.gender.name ?? 'other'),
                style: TextStyle(
                  color: palette.textSecondary,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        _NotificationsBell(
          palette: palette,
          onTap: () => const NotificationsRoute().push(context),
        ),
      ],
    );
  }
}

class _NotificationsBell extends StatelessWidget {
  const _NotificationsBell({required this.palette, required this.onTap});

  final AppPalette palette;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: palette.surface,
          shape: BoxShape.circle,
          boxShadow: softShadow(opacity: 0.10),
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(
                Icons.notifications_none_rounded,
                color: palette.textPrimary,
                size: 22,
              ),
            ),
            Positioned(
              top: 11,
              right: 11,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: palette.secondary, shape: BoxShape.circle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
