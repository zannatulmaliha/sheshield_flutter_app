import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_provider.dart';
import 'package:sheshield/features/helper/presentation/screens/helper_shell.dart';
import 'package:sheshield/features/user/presentation/screens/user_shell.dart';
import 'package:sheshield/shared/entities/user_type.dart';
import 'package:sheshield/shared/widgets/mode_switch.dart';

/// Decides what the signed-in person sees, based on role:
/// - user       -> UserShell (Home/Contacts/AI Mode/Profile, original UI)
/// - helper     -> HelperShell (dashboard/history/profile)
/// - userHelper -> both, switchable via ModeSwitch
///
/// This is what /home routes to once signed in (see app_router.dart).
class RootShell extends ConsumerStatefulWidget {
  const RootShell({super.key});

  @override
  ConsumerState<RootShell> createState() => _RootShellState();
}

class _RootShellState extends ConsumerState<RootShell> {
  AppMode _mode = AppMode.user;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider).valueOrNull;
    if (user == null) return const SizedBox.shrink(); // router redirects to /login

    switch (user.userType) {
      case UserType.user:
        return const UserShell();

      case UserType.helper:
        return const HelperShell();

      case UserType.userHelper:
        return Column(
          children: [
            ModeSwitch(mode: _mode, onChanged: (m) => setState(() => _mode = m)),
            Expanded(
              child: _mode == AppMode.user ? const UserShell() : const HelperShell(),
            ),
          ],
        );
    }
  }
}