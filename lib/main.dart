import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/app/sheshield_app.dart';
import 'package:sheshield/core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(
    const ProviderScope(
      child: SheShieldApp(),
    ),
  );
}