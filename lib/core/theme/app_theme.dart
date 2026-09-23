import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_palette.dart';

/// Single source of truth for app styling. Screens should never
/// hardcode colors — pull from here so a rebrand is a one-file change.
class AppTheme {
  AppTheme._();

  static const Color midnightBase = Color(0xFF0B0F1A);
  static const Color accentEmerald = Color(0xFF10B981);
  static const Color accentPurple = Color(0xFF8B5CF6);
  static const Color accentOrange = Color(0xFFEA580C);
  static const Color accentRed = Color(0xFFDC2626);

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: midnightBase,
      colorScheme: base.colorScheme.copyWith(
        primary: accentEmerald,
        secondary: accentPurple,
        error: accentRed,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E1B4B),
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }

  static List<Color>? get heroGradient => null;

  /// Theme for the User-mode feature (home/contacts/AI mode/profile/SOS/
  /// notifications/verification/check-in), parameterized by [palette] so a
  /// light/dark choice (see [resolvePalette]) actually changes what's on
  /// screen -- scaffold background, default text colors, card color, all
  /// derive from the same palette a screen's own explicit
  /// `colors.textPrimary`-style styling uses. Scoped locally via a `Theme`
  /// widget in `UserShell` rather than applied app-wide, since Helper/Auth
  /// keep the fixed dark theme above regardless of this choice.
  static ThemeData themeFor(AppPalette palette) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: palette == AppPalette.dark ? Brightness.dark : Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: palette.primary,
        brightness: palette == AppPalette.dark ? Brightness.dark : Brightness.light,
        primary: palette.primary,
        secondary: palette.secondary,
        surface: palette.surface,
      ),
      scaffoldBackgroundColor: palette.background,
      fontFamily: GoogleFonts.manrope().fontFamily,
    );

    return base.copyWith(
      textTheme: GoogleFonts.manropeTextTheme(base.textTheme).copyWith(
        headlineSmall: GoogleFonts.manrope(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: palette.textPrimary,
        ),
        titleLarge: GoogleFonts.manrope(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: palette.textPrimary,
        ),
        titleMedium: GoogleFonts.manrope(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: palette.textPrimary,
        ),
        bodyMedium: GoogleFonts.manrope(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: palette.textSecondary,
          height: 1.4,
        ),
        bodySmall: GoogleFonts.manrope(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: palette.textSecondary,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: palette.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      splashFactory: InkRipple.splashFactory,
    );
  }
}

/// Reusable soft shadow used for floating cards / nav bars in User mode.
/// The default color is [AppPalette.primary], identical in light and dark
/// (see [AppPalette]), so callers that only ever pass [opacity] don't need
/// to thread a palette through just for this.
List<BoxShadow> softShadow({Color color = const Color(0xFF6C3CE9), double opacity = 0.12}) {
  return [
    BoxShadow(
      color: color.withValues(alpha: opacity),
      blurRadius: 24,
      offset: const Offset(0, 10),
    ),
  ];
}