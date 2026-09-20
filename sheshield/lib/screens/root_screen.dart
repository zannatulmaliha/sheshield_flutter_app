import 'package:flutter/material.dart';
import '../widgets/app_bottom_nav.dart';
import 'ai_mode_screen.dart';
import 'contacts_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _index = 0;

  void _goTo(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(onOpenContacts: () => _goTo(1)),
      const ContactsScreen(),
      const AiModeScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _index, children: screens),
      bottomNavigationBar: AppBottomNav(currentIndex: _index, onTap: _goTo),
    );
  }
}
