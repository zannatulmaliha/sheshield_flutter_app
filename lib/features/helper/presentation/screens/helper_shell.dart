import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Bottom-tab shell for a signed-in helper: Dashboard / History /
/// Profile. Each tab is its own branch of a StatefulShellRoute (see
/// app_router.dart); the verification gate and dashboard's own
/// isVerified/onVerify wiring live in that route's screen wrapper, not
/// here -- this shell is just the tab scaffold.
class HelperShell extends StatelessWidget {
  const HelperShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history_rounded),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
