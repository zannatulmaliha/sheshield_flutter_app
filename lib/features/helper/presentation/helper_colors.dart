import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme_mode.dart';
import 'package:sheshield/features/settings/presentation/providers/theme_mode_provider.dart';

/// Gives helper widgets the SAME palette the User screens use, without
/// needing a WidgetRef in every (Stateless) widget: `context.hp.surface`,
/// `context.hp.textPrimary`, ...
extension HelperColors on BuildContext {
  AppPalette get hp {
    final mode = ProviderScope.containerOf(this).read(themeModeControllerProvider).valueOrNull ?? AppThemeMode.system;
    final isDark = switch (mode) {
      AppThemeMode.light => false,
      AppThemeMode.dark => true,
      AppThemeMode.system => MediaQuery.platformBrightnessOf(this) == Brightness.dark,
    };
    return isDark ? AppPalette.dark : AppPalette.light;
  }
}