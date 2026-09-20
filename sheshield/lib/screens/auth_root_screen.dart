import 'package:flutter/material.dart';
import '../services/auth_controller.dart';
import '../widgets/app_bottom_nav.dart';
import 'ai_mode_screen.dart';
import 'auth_profile_screen.dart';
import 'contacts_screen.dart';
import 'home_screen.dart';

/// Same as RootScreen, except the Profile tab is [AuthProfileScreen] so it
/// can show the signed-in user and offer Log Out. Kept as a separate file so
/// your original root_screen.dart isn't modified.
class AuthRootScreen extends StatefulWidget {
  const AuthRootScreen({super.key, required this.controller});

  final AuthController controller;

  @override
  State<AuthRootScreen> createState() => _AuthRootScreenState();
}

class _AuthRootScreenState extends State<AuthRootScreen> {
  int _index = 0;

  void _goTo(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(onOpenContacts: () => _goTo(1)),
      const ContactsScreen(),
      const AiModeScreen(),
      AuthProfileScreen(controller: widget.controller),
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _index, children: screens),
      bottomNavigationBar: AppBottomNav(currentIndex: _index, onTap: _goTo),
    );
  }
}
