import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sheshield/features/auth/presentation/screens/login_screen.dart';
import 'package:sheshield/features/auth/presentation/screens/signup_screen.dart';
import 'package:sheshield/features/verification/presentation/screens/verification_screen.dart';

part 'auth_routes.g.dart';

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

/// Pushed from the helper dashboard's "verify" gate, or reachable via a
/// future deep link / notification tap.
@TypedGoRoute<VerificationRoute>(path: '/verification')
class VerificationRoute extends GoRouteData {
  const VerificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const VerificationScreen();
}
