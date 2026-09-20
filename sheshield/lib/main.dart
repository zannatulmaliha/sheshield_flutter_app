import 'package:flutter/material.dart';
import 'screens/root_screen.dart';
import 'state/game_scope.dart';
import 'state/game_state.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SheShieldApp());
}

class SheShieldApp extends StatefulWidget {
  const SheShieldApp({super.key});

  @override
  State<SheShieldApp> createState() => _SheShieldAppState();
}

class _SheShieldAppState extends State<SheShieldApp> {
  final GameState _game = GameState();

  @override
  void dispose() {
    _game.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SheShield',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      // Wraps the Navigator (not just `home`), so GameScope stays reachable
      // from pushed routes too, e.g. the SOS and level-up overlays.
      builder: (context, child) => GameScope(state: _game, child: child!),
      home: const RootScreen(),
    );
  }
}
