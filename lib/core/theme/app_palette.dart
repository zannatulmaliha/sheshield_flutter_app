import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/features/settings/presentation/providers/theme_mode_provider.dart';
import 'app_theme_mode.dart';

/// The color tokens every User-mode screen (Home, Contacts, Profile, SOS,
/// Notifications, Verification, Check-in) pulls from -- resolved at build
/// time via [resolvePalette], never a compile-time constant, so a
/// light/dark choice can actually change what's on screen. Brand/status
/// colors (primary, secondary, the SOS/success/warning colors) stay
/// identical between [light] and [dark] on purpose -- only the neutral
/// surface/text tokens invert, which is enough contrast to read correctly
/// in both and keeps the brand recognizable either way.
class AppPalette {
  const AppPalette({
    required this.primary,
    required this.primaryDark,
    required this.secondary,
    required this.sosStart,
    required this.sosEnd,
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.success,
    required this.warning,
    required this.chipBackground,
    required this.heroGradient,
    required this.sosGradient,
    required this.aiGradient,
  });

  final Color primary;
  final Color primaryDark;
  final Color secondary;
  final Color sosStart;
  final Color sosEnd;
  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color success;
  final Color warning;
  final Color chipBackground;
  final List<Color> heroGradient;
  final List<Color> sosGradient;
  final List<Color> aiGradient;

  static const _primary = Color(0xFF6C3CE9);
  static const _primaryDark = Color(0xFF4A22B8);
  static const _secondary = Color(0xFFFF5C8A);
  static const _sosStart = Color(0xFFFF4B6E);
  static const _sosEnd = Color(0xFFC2185B);
  static const _success = Color(0xFF2FC28E);
  static const _warning = Color(0xFFFFA94D);
  static const _heroGradient = [Color(0xFF7B2FF7), Color(0xFFB53FE0)];
  static const _sosGradient = [_sosStart, _sosEnd];
  static const _aiGradient = [Color(0xFF3F5EFB), Color(0xFF9C42F5)];

  static const light = AppPalette(
    primary: _primary,
    primaryDark: _primaryDark,
    secondary: _secondary,
    sosStart: _sosStart,
    sosEnd: _sosEnd,
    background: Color(0xFFF7F5FC),
    surface: Colors.white,
    textPrimary: Color(0xFF231B3B),
    textSecondary: Color(0xFF867F9B),
    success: _success,
    warning: _warning,
    chipBackground: Color(0xFFF0EBFB),
    heroGradient: _heroGradient,
    sosGradient: _sosGradient,
    aiGradient: _aiGradient,
  );

  static const dark = AppPalette(
    primary: _primary,
    primaryDark: _primaryDark,
    secondary: _secondary,
    sosStart: _sosStart,
    sosEnd: _sosEnd,
    background: Color(0xFF15121F),
    surface: Color(0xFF211D33),
    textPrimary: Color(0xFFF5F3FA),
    textSecondary: Color(0xFFA79FC2),
    success: _success,
    warning: _warning,
    chipBackground: Color(0xFF2A2440),
    heroGradient: _heroGradient,
    sosGradient: _sosGradient,
    aiGradient: _aiGradient,
  );
}

/// Resolves which [AppPalette] is active right now: the person's explicit
/// light/dark choice, or (for "system") the device's own current
/// brightness. Reads [themeModeControllerProvider] reactively via [ref] --
/// unlike a `Theme.of(context)` lookup, this works identically for a screen
/// pushed on the root navigator or a modal bottom sheet, not just widgets
/// nested under a particular `Theme` wrapper, since it never depends on
/// where in the widget tree it's called from.
AppPalette resolvePalette(BuildContext context, WidgetRef ref) {
  final mode = ref.watch(themeModeControllerProvider).valueOrNull ?? AppThemeMode.system;
  final isDark = switch (mode) {
    AppThemeMode.light => false,
    AppThemeMode.dark => true,
    AppThemeMode.system => MediaQuery.platformBrightnessOf(context) == Brightness.dark,
  };
  return isDark ? AppPalette.dark : AppPalette.light;
}
