import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/user/presentation/widgets/app_bottom_nav.dart';

/// Bottom-tab shell for a signed-in user: Home / Contacts / AI Mode /
/// Profile. Each tab is its own branch of a StatefulShellRoute (see
/// app_router.dart), so [navigationShell] both renders the active
/// branch's stack and remembers each branch's own navigation history.
class UserShell extends StatelessWidget {
  const UserShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    // Scoped to AppTheme.light so User-mode keeps its original look even
    // though the app's global MaterialApp theme (Auth/Helper) is dark.
    return Theme(
      data: AppTheme.light,
      child: Scaffold(
        extendBody: true,
        body: navigationShell,
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
