import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sheshield/core/router/routes/shell_routes.dart';
import 'package:sheshield/features/contacts/presentation/screens/contacts_screen.dart';
import 'package:sheshield/features/user/presentation/screens/ai_mode_screen.dart';
import 'package:sheshield/features/user/presentation/screens/home_screen.dart';
import 'package:sheshield/features/user/presentation/screens/profile_screen.dart';
import 'package:sheshield/features/user/presentation/screens/user_shell.dart';

// Plain route data for the user bottom-tab shell. The annotations that
// wire these into the tree live in shell_routes.dart.

class UserShellRouteData extends StatefulShellRouteData {
  const UserShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) =>
      UserShell(navigationShell: navigationShell);
}

class UserHomeBranchData extends StatefulShellBranchData {
  const UserHomeBranchData();
}

class UserContactsBranchData extends StatefulShellBranchData {
  const UserContactsBranchData();
}

class UserAiBranchData extends StatefulShellBranchData {
  const UserAiBranchData();
}

class UserProfileBranchData extends StatefulShellBranchData {
  const UserProfileBranchData();
}

class UserHomeRoute extends GoRouteData {
  const UserHomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      HomeScreen(onOpenContacts: () => const UserContactsRoute().go(context));
}

class UserContactsRoute extends GoRouteData {
  const UserContactsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const ContactsScreen();
}

class UserAiRoute extends GoRouteData {
  const UserAiRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const AiModeScreen();
}

class UserProfileRoute extends GoRouteData {
  const UserProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const ProfileScreen();
}
