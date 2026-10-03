import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/app/sheshield_app.dart';
import 'package:sheshield/core/config/app_config.dart';
import 'package:sheshield/core/config/app_config_provider.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/services/push_service.dart';

/// Shared startup path for every flavor. Each `main_<flavor>.dart` only
/// picks an [AppConfig] and calls this.
Future<void> bootstrap(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies(config);

  // Android reads android/app/<flavor>/google-services.json at build time.
  await Firebase.initializeApp();
  await getIt<PushService>().initialize();

  runApp(
    ProviderScope(
      overrides: [appConfigProvider.overrideWithValue(config)],
      child: const SheShieldApp(),
    ),
  );
}
