import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_provider.dart';
import 'package:sheshield/features/auth/presentation/screens/login_screen.dart';
import 'package:sheshield/features/auth/presentation/screens/signup_screen.dart';
import 'package:sheshield/features/contacts/presentation/screens/contacts_screen.dart';
import 'package:sheshield/features/helper/domain/entities/accepted_alert.dart';
import 'package:sheshield/features/helper/presentation/screens/helper_alert_detail_screen.dart';
import 'package:sheshield/features/helper/presentation/screens/helper_dashboard_screen.dart';
import 'package:sheshield/features/helper/presentation/screens/helper_shell.dart';
import 'package:sheshield/features/user/presentation/screens/ai_mode_screen.dart';
import 'package:sheshield/features/user/presentation/screens/home_screen.dart';
import 'package:sheshield/features/user/presentation/screens/profile_screen.dart';
import 'package:sheshield/features/user/presentation/screens/user_shell.dart';
import 'package:sheshield/features/user/presentation/widgets/sos_activated_view.dart';
import 'package:sheshield/features/verification/presentation/screens/verification_screen.dart';
import 'package:sheshield/shared/entities/user_type.dart';
import 'root_shell.dart';

part 'app_router.g.dart';

/// Lets code outside the widget tree (PushService, reacting to an FCM
/// message with no BuildContext of its own) show the full-screen SOS alarm
/// on top of whatever go_router currently displays, via a plain imperative
/// Navigator.push -- bypassing the router's auth/role redirect logic
/// entirely, which a go_router location change would otherwise fight.
final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Single source of truth for navigation, as typed [GoRouteData] classes
/// (go_router_builder codegen). Run `dart run build_runner build
/// --delete-conflicting-outputs` after adding/changing a route -- it
/// (re)generates `app_router.g.dart`, including each route's extension
/// methods (`.location`, `.go()`, etc.) below.
///
/// Every screen-to-screen navigation in the app goes through this file --
/// including the two bottom-tab shells (user/helper), which are
/// [StatefulShellRoute]s so each tab keeps its own navigation stack and
/// the current tab shows up in the URL. Dialogs and bottom sheets are not
/// routes (go_router has no opinion on those) and stay as showDialog /
/// showModalBottomSheet at their call sites.
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: const LoginRoute().location,
    redirect: (context, state) {
      if (authState.isLoading) return null; // still resolving; don't redirect yet

      final user = authState.valueOrNull;
      final loc = state.matchedLocation;
      final isAuthRoute = loc == const LoginRoute().location || loc == const SignupRoute().location;

      if (user == null) return isAuthRoute ? null : const LoginRoute().location;
      if (isAuthRoute) return _defaultHomeLocation(user.userType);

      // Role gate: a plain "user" can't land in the helper tabs and vice
      // versa. A dual-role userHelper account may visit either (that's
      // what the ModeSwitch in RootShell is for).
      final isHelperArea = loc.startsWith('/home/helper');
      final isUserArea = loc.startsWith('/home/user');
      if (isHelperArea && user.userType == UserType.user) return const UserHomeRoute().location;
      if (isUserArea && user.userType == UserType.helper) return const HelperDashboardRoute().location;
      if (loc == '/home') return _defaultHomeLocation(user.userType);

      return null;
    },
    routes: $appRoutes,
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Route not found: ${state.uri}')),
    ),
  );
});

String _defaultHomeLocation(UserType type) =>
    type == UserType.helper ? const HelperDashboardRoute().location : const UserHomeRoute().location;

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginScreen();
}

@TypedGoRoute<SignupRoute>(path: '/signup')
class SignupRoute extends GoRouteData {
  const SignupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignupScreen();
}

/// Pushed from the helper dashboard's "verify" gate, or reachable directly
/// via a future deep link / notification tap.
@TypedGoRoute<VerificationRoute>(path: '/verification')
class VerificationRoute extends GoRouteData {
  const VerificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const VerificationScreen();
}

/// Full-screen "SOS Alert Sent" confirmation, pushed right after a
/// successful send. Kept as a transparent overlay page (via [buildPage])
/// so it still reads as a modal floating over Home, not a full page
/// transition.
@TypedGoRoute<SosSentRoute>(path: '/sos-sent')
class SosSentRoute extends GoRouteData {
  const SosSentRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) => CustomTransitionPage<void>(
        opaque: false,
        barrierColor: Colors.black87,
        barrierDismissible: false,
        transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
        child: const SosActivatedView(),
      );
}

/// The one screen that shows a helper's exact match -- location + phone --
/// after they win an accept race. [$extra] carries the [AcceptedAlert]
/// returned by that call; it's never round-tripped through a URL because
/// it's momentary, race-won data, not something worth deep-linking to.
@TypedGoRoute<HelperAlertDetailRoute>(path: '/helper-alert')
class HelperAlertDetailRoute extends GoRouteData {
  const HelperAlertDetailRoute({required this.$extra});

  final AcceptedAlert $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) => HelperAlertDetailScreen(alert: $extra);
}

/// Wraps whichever role-shell is active. Renders the [ModeSwitch] header
/// for dual-role (userHelper) accounts; a plain user or helper account
/// never sees it (there's nothing to switch between).
@TypedShellRoute<RootShellRouteData>(
  routes: [
    TypedStatefulShellRoute<UserShellRouteData>(
      branches: [
        TypedStatefulShellBranch<UserHomeBranchData>(
          routes: [TypedGoRoute<UserHomeRoute>(path: '/home/user')],
        ),
        TypedStatefulShellBranch<UserContactsBranchData>(
          routes: [TypedGoRoute<UserContactsRoute>(path: '/home/user/contacts')],
        ),
        TypedStatefulShellBranch<UserAiBranchData>(
          routes: [TypedGoRoute<UserAiRoute>(path: '/home/user/ai')],
        ),
        TypedStatefulShellBranch<UserProfileBranchData>(
          routes: [TypedGoRoute<UserProfileRoute>(path: '/home/user/profile')],
        ),
      ],
    ),
    TypedStatefulShellRoute<HelperShellRouteData>(
      branches: [
        TypedStatefulShellBranch<HelperDashboardBranchData>(
          routes: [TypedGoRoute<HelperDashboardRoute>(path: '/home/helper')],
        ),
        TypedStatefulShellBranch<HelperHistoryBranchData>(
          routes: [TypedGoRoute<HelperHistoryRoute>(path: '/home/helper/history')],
        ),
        TypedStatefulShellBranch<HelperProfileBranchData>(
          routes: [TypedGoRoute<HelperProfileRoute>(path: '/home/helper/profile')],
        ),
      ],
    ),
  ],
)
class RootShellRouteData extends ShellRouteData {
  const RootShellRouteData();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) => RootShell(child: navigator);
}

// --- User shell: Home / Contacts / AI Mode / Profile -----------------------

class UserShellRouteData extends StatefulShellRouteData {
  const UserShellRouteData();

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) =>
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

// --- Helper shell: Dashboard / History / Profile ----------------------------

class HelperShellRouteData extends StatefulShellRouteData {
  const HelperShellRouteData();

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) =>
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
  Widget build(BuildContext context, GoRouterState state) => const _HelperDashboardRouteScreen();
}

/// Reads [authStateProvider] for the verification gate, then hands off to
/// the plain [HelperDashboardScreen]. A small wrapper because [GoRouteData]
/// route classes aren't riverpod consumers themselves.
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

  // History remains a placeholder -- out of scope until a "past alerts"
  // endpoint exists on the backend.
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const Center(child: Text('Response history — coming soon'));
}

class HelperProfileRoute extends GoRouteData {
  const HelperProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const ProfileScreen();
}
