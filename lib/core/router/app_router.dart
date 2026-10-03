import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/router/app_redirect.dart';
import 'package:sheshield/core/router/routes/admin_routes.dart' as admin;
import 'package:sheshield/core/router/routes/auth_routes.dart' as auth;
import 'package:sheshield/core/router/routes/shell_routes.dart' as shell;
import 'package:sheshield/core/router/routes/sos_routes.dart' as sos;
import 'package:sheshield/features/auth/presentation/providers/auth_provider.dart';

// Every typed route class stays importable from this one file. The
// generated `$appRoutes` getters collide when re-exported together, so
// they are hidden here and combined below under import prefixes.
export 'package:sheshield/core/router/routes/admin_routes.dart' hide $appRoutes;
export 'package:sheshield/core/router/routes/auth_routes.dart' hide $appRoutes;
export 'package:sheshield/core/router/routes/helper_tab_routes.dart';
export 'package:sheshield/core/router/routes/shell_routes.dart' hide $appRoutes;
export 'package:sheshield/core/router/routes/sos_routes.dart' hide $appRoutes;
export 'package:sheshield/core/router/routes/user_tab_routes.dart';

/// Lets code outside the widget tree (PushService reacting to an FCM
/// message) show the full-screen SOS alarm via a plain `Navigator.push`,
/// bypassing the router's auth/role redirect that a location change would
/// fight.
final rootNavigatorKey = GlobalKey<NavigatorState>();

/// Single source of truth for navigation. Run
/// `dart run build_runner build --delete-conflicting-outputs` after adding
/// or changing a route. Dialogs and bottom sheets are not routes.
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: const auth.LoginRoute().location,
    redirect: (context, state) => resolveRedirect(
      location: state.matchedLocation,
      isAuthResolving: authState.isLoading,
      user: authState.valueOrNull,
    ),
    routes: [
      ...auth.$appRoutes,
      ...sos.$appRoutes,
      ...admin.$appRoutes,
      ...shell.$appRoutes,
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Route not found: ${state.uri}')),
    ),
  );
});
