import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/user/presentation/widgets/app_bottom_nav.dart';
import 'package:sheshield/shared/widgets/aurora_background.dart';

/// Bottom-tab shell for a signed-in user: Home / Contacts / AI Mode /
/// Profile. Each tab is its own branch of a StatefulShellRoute (see
/// app_router.dart), so [navigationShell] both renders the active
/// branch's stack and remembers each branch's own navigation history.
class UserShell extends ConsumerWidget {
  const UserShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Scoped to a User-mode theme (light or dark, per the person's own
    // choice -- see resolvePalette) so User-mode keeps its own look even
    // though the app's global MaterialApp theme (Auth/Helper) is always
    // the fixed dark "midnight" theme regardless of this choice.
    return Theme(
      data: AppTheme.themeFor(resolvePalette(context, ref)),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            const AuroraBackground(),
            navigationShell,
          ],
        ),
        bottomNavigationBar: AppBottomNav(
          currentIndex: navigationShell.currentIndex,
          onTap: (index) => navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          ),
        ),
      ),
    );
  }
}
