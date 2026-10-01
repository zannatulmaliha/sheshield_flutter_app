import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/auth/presentation/providers/auth_provider.dart';
import 'package:sheshield/features/user/presentation/screens/profile_screen.dart';
import 'package:sheshield/features/user/presentation/widgets/app_bottom_nav.dart';
import 'package:sheshield/shared/widgets/aurora_background.dart';
import '../widgets/helper_not_verified_view.dart';
import 'helper_alerts_screen.dart';
import 'helper_dashboard_screen.dart';
import 'helper_history_screen.dart';
import 'helper_support_screen.dart';

const List<NavItemData> _helperNavItems = [
  NavItemData(Icons.dashboard_outlined, Icons.dashboard_rounded, 'Home'),
  NavItemData(Icons.notifications_none_rounded, Icons.notifications_rounded, 'Alerts'),
  NavItemData(Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
  NavItemData(Icons.info_outline_rounded, Icons.info_rounded, 'Support'),
  NavItemData(Icons.list_alt_outlined, Icons.list_alt_rounded, 'History'),
];

/// Bottom-tab shell for a signed-in helper:
/// Dashboard / Alerts / Profile / Support / History.
///
/// Uses the SAME look as the User shell (themed Scaffold, aurora
/// background, floating bottom bar). The five tabs live in an IndexedStack
/// so switching tabs never reloads a list or drops a scroll position.
class HelperShell extends ConsumerStatefulWidget {
  const HelperShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<HelperShell> createState() => _HelperShellState();
}

class _HelperShellState extends ConsumerState<HelperShell> {
  int _index = 0;

  static const _titles = ['Helper Dashboard', 'Alerts', 'Profile', 'Help & Support', 'History'];

  @override
  Widget build(BuildContext context) {
    final colors = resolvePalette(context, ref);
    final user = ref.watch(authStateProvider).valueOrNull;
    final verified = user?.isHelperVerified ?? false;

    Widget gated(Widget child) => verified ? child : HelperNotVerifiedView(onVerify: () => const VerificationRoute().push(context));

    final pages = <Widget>[
      HelperDashboardScreen(isVerified: verified, onVerify: () => const VerificationRoute().push(context)),
      gated(const HelperAlertsScreen()),
      const ProfileScreen(),
      const HelperSupportScreen(),
      gated(const HelperHistoryScreen()),
    ];

    // Dashboard and Profile draw their own heading, like the User tabs do.
    final showTitle = _index != 0 && _index != 2;

    return Theme(
      data: AppTheme.themeFor(colors),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            const AuroraBackground(),
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  if (showTitle)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(_titles[_index], style: Theme.of(context).textTheme.headlineSmall),
                      ),
                    ),
                  Expanded(child: IndexedStack(index: _index, children: pages)),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: AppBottomNav(
          items: _helperNavItems,
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
        ),
      ),
    );
  }
}