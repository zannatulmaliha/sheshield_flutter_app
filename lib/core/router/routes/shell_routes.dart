import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:sheshield/core/router/root_shell.dart';
import 'package:sheshield/core/router/routes/helper_tab_routes.dart';
import 'package:sheshield/core/router/routes/user_tab_routes.dart';

part 'shell_routes.g.dart';

/// Wraps whichever role shell is active. Renders the mode switch for
/// dual-role accounts; a plain user or helper never sees it. Each role
/// shell is a StatefulShellRoute, so every tab keeps its own stack.
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
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) =>
      RootShell(child: navigator);
}
