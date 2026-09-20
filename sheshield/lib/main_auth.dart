import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth_root_screen.dart';
import 'services/auth_controller.dart';
import 'theme/app_theme.dart';

/// Login-gated entry point. Run with:
///   flutter run -t lib/main_auth.dart
/// Your original lib/main.dart is untouched and still runs the app without
/// login. Once you're happy with this one, you can make it the default by
/// moving this file's contents into main.dart.
void main() {
  runApp(const SheShieldAuthApp());
}

class SheShieldAuthApp extends StatefulWidget {
  const SheShieldAuthApp({super.key});

  @override
  State<SheShieldAuthApp> createState() => _SheShieldAuthAppState();
}

class _SheShieldAuthAppState extends State<SheShieldAuthApp> {
  final _auth = AuthController();

  @override
  void initState() {
    super.initState();
    _auth.checkSession();
  }

  @override
  void dispose() {
    _auth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SheShield',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: AnimatedBuilder(
        animation: _auth,
        builder: (context, _) {
          return switch (_auth.status) {
            // Splash while the saved token is verified against the backend.
            AuthStatus.checking => const _SplashScreen(),
            AuthStatus.signedOut => LoginScreen(controller: _auth),
            AuthStatus.signedIn => AuthRootScreen(controller: _auth),
          };
        },
      ),
    );
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Container(
          width: 84,
          height: 84,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(colors: AppColors.heroGradient),
            boxShadow: softShadow(color: AppColors.primary, opacity: 0.3),
          ),
          child: const Icon(Icons.shield_rounded, color: Colors.white, size: 40),
        ),
      ),
    );
  }
}
