import 'package:flutter/material.dart';
import '../services/auth_controller.dart';
import '../services/contacts_store.dart';
import '../widgets/app_bottom_nav.dart';
import 'ai_mode_screen.dart';
import 'auth_contacts_screen.dart';
import 'auth_home_screen.dart';
import 'auth_profile_screen.dart';

/// Same as RootScreen, but signed-in: it owns the shared contacts list (used
/// by both Home and Contacts), and Home/Contacts/Profile are the versions
/// that use real account data. Kept separate so your original
/// root_screen.dart isn't modified.
class AuthRootScreen extends StatefulWidget {
  const AuthRootScreen({super.key, required this.controller});

  final AuthController controller;

  @override
  State<AuthRootScreen> createState() => _AuthRootScreenState();
}

class _AuthRootScreenState extends State<AuthRootScreen> {
  int _index = 0;
  late final ContactsStore _contacts;

  @override
  void initState() {
    super.initState();
    _contacts = ContactsStore(
      userId: widget.controller.currentUser?.uid ?? '',
      onSessionExpired: widget.controller.logout,
    );
    _contacts.init();
  }

  @override
  void dispose() {
    _contacts.dispose();
    super.dispose();
  }

  void _goTo(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    final screens = [
      AuthHomeScreen(
        controller: widget.controller,
        store: _contacts,
        onOpenContacts: () => _goTo(1),
      ),
      AuthContactsScreen(store: _contacts),
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
