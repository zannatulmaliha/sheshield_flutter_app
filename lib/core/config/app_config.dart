import 'package:sheshield/core/config/app_flavor.dart';

/// Immutable, per-flavor settings. Created once by a `main_<flavor>.dart`
/// entry point and handed to `bootstrap`; nothing else reads build flags.
class AppConfig {
  const AppConfig({
    required this.flavor,
    required this.apiBaseUrl,
    required this.enableNetworkLogging,
  });

  final AppFlavor flavor;
  final String apiBaseUrl;
  final bool enableNetworkLogging;

  String get appTitle => 'SheShield${flavor.displaySuffix}';

  /// Local backend. `10.0.2.2` is the Android emulator's alias for the
  /// host machine; override with `--dart-define=API_BASE_URL=...`.
  static const _devDefaultUrl = 'http://10.0.2.2:8080/api/v1';

  static const dev = AppConfig(
    flavor: AppFlavor.dev,
    apiBaseUrl: String.fromEnvironment('API_BASE_URL', defaultValue: _devDefaultUrl),
    enableNetworkLogging: true,
  );

  static const staging = AppConfig(
    flavor: AppFlavor.staging,
    apiBaseUrl: String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://staging.api.sheshield.app/api/v1',
    ),
    enableNetworkLogging: true,
  );

  static const production = AppConfig(
    flavor: AppFlavor.production,
    apiBaseUrl: String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.sheshield.app/api/v1',
    ),
    enableNetworkLogging: false,
  );
}
