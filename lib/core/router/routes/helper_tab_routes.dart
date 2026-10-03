import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sheshield/core/router/routes/auth_routes.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_provider.dart';
import 'package:sheshield/features/helper/presentation/screens/helper_dashboard_screen.dart';
import 'package:sheshield/features/helper/presentation/screens/helper_shell.dart';
import 'package:sheshield/features/user/presentation/screens/profile_screen.dart';

// Plain route data for the helper bottom-tab shell. The annotations that
// wire these into the tree live in shell_routes.dart.

class HelperShellRouteData extends StatefulShellRouteData {
  const HelperShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) =>
      HelperShell(navigationShell: navigationShell);
}

class HelperDashboardBranchData extends StatefulShellBranchData {
  const HelperDashboardBranchData();
}

class HelperHistoryBranchData extends StatefulShellBranchData {
  const HelperHistoryBranchData();
}

class HelperProfileBranchData extends StatefulShellBranchData {
  const HelperProfileBranchData();
}

class HelperDashboardRoute extends GoRouteData {
  const HelperDashboardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const _HelperDashboardRouteScreen();
}

/// Reads the auth state for the verification gate, then hands off to the
/// plain dashboard (route data classes aren't Riverpod consumers).
class _HelperDashboardRouteScreen extends ConsumerWidget {
  const _HelperDashboardRouteScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).valueOrNull;
    return HelperDashboardScreen(
      isVerified: user?.isHelperVerified ?? false,
      onVerify: () => const VerificationRoute().push(context),
    );
  }
}

class HelperHistoryRoute extends GoRouteData {
  const HelperHistoryRoute();

  // Placeholder until a "past alerts" endpoint exists on the backend.
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const Center(child: Text('Response history — coming soon'));
}

class HelperProfileRoute extends GoRouteData {
  const HelperProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const ProfileScreen();
}
