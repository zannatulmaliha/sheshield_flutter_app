import 'package:sheshield/bootstrap.dart';
import 'package:sheshield/core/config/app_config.dart';

/// Default entry point = dev flavor. Use `-t lib/main_staging.dart` or
/// `-t lib/main_production.dart` (with `--flavor`) for the others.
Future<void> main() => bootstrap(AppConfig.dev);
