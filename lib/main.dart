import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/app/sheshield_app.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/services/push_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  // On Android, no explicit options are needed: the Google Services Gradle
  // plugin reads android/app/google-services.json at build time and this
  // picks up that native default app.
  await Firebase.initializeApp();
  await getIt<PushService>().initialize();

  runApp(
    const ProviderScope(
      child: SheShieldApp(),
    ),
  );
}