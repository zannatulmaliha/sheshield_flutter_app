import 'package:flutter/material.dart';
import 'screens/root_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const SheShieldApp());
}

class SheShieldApp extends StatelessWidget {
  const SheShieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SheShield',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const RootScreen(),
    );
  }
}
