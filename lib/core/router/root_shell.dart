import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_provider.dart';
import 'package:sheshield/shared/entities/user_type.dart';
import 'package:sheshield/shared/widgets/mode_switch.dart';

/// Wraps whichever role-shell go_router put in [child] (the user tabs or
/// the helper tabs -- see the nested StatefulShellRoutes in
/// app_router.dart). For a dual-role (userHelper) account, this is also
/// where the [ModeSwitch] header lives, since it needs to see the
/// current location to know which mode is active and route-level
/// [redirect] already guards a plain user/helper from reaching the
/// other role's tabs.
class RootShell extends ConsumerWidget {
  const RootShell({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).valueOrNull;
    if (user == null) return const SizedBox.shrink(); // router redirects to /login
    if (user.userType != UserType.userHelper) return child;

    final isHelperArea = GoRouterState.of(context).matchedLocation.startsWith('/home/helper');
    return Column(
      children: [
        ModeSwitch(
          mode: isHelperArea ? AppMode.helper : AppMode.user,
          onChanged: (m) {
            if (m == AppMode.helper) {
              const HelperDashboardRoute().go(context);
            } else {
              const UserHomeRoute().go(context);
            }
          },
        ),
        Expanded(child: child),
      ],
    );
  }
}
