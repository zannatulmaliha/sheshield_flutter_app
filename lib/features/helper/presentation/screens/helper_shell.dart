import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_provider.dart';
import 'package:sheshield/features/user/presentation/screens/profile_screen.dart';
import 'package:sheshield/features/verification/presentation/screens/verification_screen.dart';
import 'helper_dashboard_screen.dart';

enum _HelperTab { dashboard, history, profile }

/// The bottom-nav shell for a signed-in helper.
/// History remains a placeholder -- out of scope until a "past alerts"
/// endpoint exists on the backend.
class HelperShell extends ConsumerStatefulWidget {
  const HelperShell({super.key});

  @override
  ConsumerState<HelperShell> createState() => _HelperShellState();
}

class _HelperShellState extends ConsumerState<HelperShell> {
  _HelperTab _tab = _HelperTab.dashboard;

  void _openVerification() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const VerificationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider).valueOrNull;
    if (user == null) return const SizedBox.shrink(); // router redirects to /login

    final body = switch (_tab) {
      _HelperTab.dashboard => HelperDashboardScreen(
          isVerified: user.isHelperVerified,
          onVerify: _openVerification,
        ),
      _HelperTab.history => const _Placeholder('Response history — coming soon'),
      _HelperTab.profile => const ProfileScreen(),
    };

    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab.index,
        onDestinationSelected: (i) => setState(() => _tab = _HelperTab.values[i]),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history_rounded),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Center(child: Text(text));
}