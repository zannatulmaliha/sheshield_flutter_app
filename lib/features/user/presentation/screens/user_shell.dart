import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/user/presentation/widgets/app_bottom_nav.dart';
import 'ai_mode_screen.dart';
import 'package:sheshield/features/contacts/presentation/screens/contacts_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';

class UserShell extends StatefulWidget {
  const UserShell({super.key});

  @override
  State<UserShell> createState() => _UserShellState();
}

class _UserShellState extends State<UserShell> {
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

    // Scoped to AppTheme.light so User-mode keeps its original look even
    // though the app's global MaterialApp theme (Auth/Helper) is dark.
    return Theme(
      data: AppTheme.light,
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(index: _index, children: screens),
        bottomNavigationBar: AppBottomNav(currentIndex: _index, onTap: _goTo),
      ),
    );
  }
}