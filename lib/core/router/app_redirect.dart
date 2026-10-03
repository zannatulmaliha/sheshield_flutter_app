import 'package:sheshield/core/router/routes/auth_routes.dart';
import 'package:sheshield/core/router/routes/helper_tab_routes.dart';
import 'package:sheshield/core/router/routes/shell_routes.dart';
import 'package:sheshield/core/router/routes/user_tab_routes.dart';
import 'package:sheshield/shared/entities/app_user.dart';
import 'package:sheshield/shared/entities/user_type.dart';

/// Pure routing policy: given who is signed in and where they are going,
/// where should they actually land? Returns null to stay put.
///
/// Admin URLs authenticate with a separate server-side key, so they bypass
/// the user auth redirect entirely.
String? resolveRedirect({
  required String location,
  required bool isAuthResolving,
  required AppUser? user,
}) {
  if (location.startsWith('/admin')) return null;
  if (isAuthResolving) return null;

  final loginLocation = const LoginRoute().location;
  final isAuthRoute = location == loginLocation || location == const SignupRoute().location;

  if (user == null) return isAuthRoute ? null : loginLocation;
  if (isAuthRoute || location == '/home') return homeLocationFor(user.userType);

  // Role gate: a plain user can't land in helper tabs and vice versa. A
  // dual-role account may visit either.
  final isHelperArea = location.startsWith('/home/helper');
  final isUserArea = location.startsWith('/home/user');
  if (isHelperArea && user.userType == UserType.user) {
    return const UserHomeRoute().location;
  }
  if (isUserArea && user.userType == UserType.helper) {
    return const HelperDashboardRoute().location;
  }
  return null;
}

String homeLocationFor(UserType type) => type == UserType.helper
    ? const HelperDashboardRoute().location
    : const UserHomeRoute().location;
