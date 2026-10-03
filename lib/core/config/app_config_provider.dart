import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/config/app_config.dart';

/// Overridden in `bootstrap` with the flavor's real config. Reading it
/// before that is a programming error, so the default throws loudly.
final appConfigProvider = Provider<AppConfig>(
  (_) => throw UnimplementedError('appConfigProvider must be overridden'),
);
