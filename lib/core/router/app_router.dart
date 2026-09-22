import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_provider.dart';
import 'package:sheshield/features/auth/presentation/screens/login_screen.dart';
import 'package:sheshield/features/auth/presentation/screens/signup_screen.dart';
import 'package:sheshield/features/verification/presentation/screens/verification_screen.dart';
import 'root_shell.dart';

part 'app_router.g.dart';

/// Single source of truth for navigation, as typed [GoRouteData] classes
/// (go_router_builder codegen). Run `dart run build_runner build
/// --delete-conflicting-outputs` after adding/changing a route -- it
/// (re)generates `app_router.g.dart`, including each route's extension
/// methods (`.location`, `.go()`, etc.) below.
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: const LoginRoute().location,
    redirect: (context, state) {
      if (authState.isLoading) return null; // still resolving; don't redirect yet

      final isLoggedIn = authState.valueOrNull != null;
      final isAuthRoute = state.matchedLocation == const LoginRoute().location ||
          state.matchedLocation == const SignupRoute().location;

      if (!isLoggedIn && !isAuthRoute) return const LoginRoute().location;
      if (isLoggedIn && isAuthRoute) return const HomeRoute().location;
      return null;
    },
    routes: $appRoutes,
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Route not found: ${state.uri}')),
    ),
  );
});

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

@TypedGoRoute<HomeRoute>(path: '/home')
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const RootShell();
}

/// Reachable from any role; the dashboard gate pushes here directly today
/// (see helper_shell.dart) rather than using `.go()`, so this route exists
/// mainly for a future deep link or notification tap.
@TypedGoRoute<VerificationRoute>(path: '/verification')
class VerificationRoute extends GoRouteData {
  const VerificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const VerificationScreen();
}