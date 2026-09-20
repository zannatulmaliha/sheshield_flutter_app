import 'package:flutter/material.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/aurora_background.dart';
import 'ai_mode_screen.dart';
import 'contacts_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with SingleTickerProviderStateMixin {
  int _index = 0;
  late final AnimationController _transitionController;

  @override
  void initState() {
    super.initState();
    _transitionController = AnimationController(vsync: this, duration: const Duration(milliseconds: 280))..value = 1;
  }

  @override
  void dispose() {
    _transitionController.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    if (index == _index) return;
    setState(() => _index = index);
    _transitionController
      ..value = 0
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    // Kept alive in an IndexedStack (not rebuilt on tab switch) so toggles,
    // scroll position, etc. survive navigation; a fade + slide overlay gives
    // the switch a smooth, animated feel without losing that state.
    final screens = [
      HomeScreen(onOpenContacts: () => _goTo(1)),
      const ContactsScreen(),
      const AiModeScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const AuroraBackground(),
          FadeTransition(
            opacity: CurvedAnimation(parent: _transitionController, curve: Curves.easeOut),
            child: SlideTransition(
              position: Tween<Offset>(begin: const Offset(0, 0.025), end: Offset.zero)
                  .animate(CurvedAnimation(parent: _transitionController, curve: Curves.easeOutCubic)),
              child: IndexedStack(index: _index, children: screens),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(currentIndex: _index, onTap: _goTo),
    );
  }
}
