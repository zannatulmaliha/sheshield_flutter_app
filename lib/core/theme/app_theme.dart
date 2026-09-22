import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  /// Light theme for the User-mode feature (home/contacts/AI mode/profile),
  /// ported from the original `auth` branch. Scoped locally via a `Theme`
  /// widget in `UserShell` rather than applied app-wide, since Helper/Auth
  /// keep the dark theme above.
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
      ),
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: GoogleFonts.manrope().fontFamily,
    );

    return base.copyWith(
      textTheme: GoogleFonts.manropeTextTheme(base.textTheme).copyWith(
        headlineSmall: GoogleFonts.manrope(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
        titleLarge: GoogleFonts.manrope(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        titleMedium: GoogleFonts.manrope(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        bodyMedium: GoogleFonts.manrope(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
          height: 1.4,
        ),
        bodySmall: GoogleFonts.manrope(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      splashFactory: InkRipple.splashFactory,
    );
  }
}

/// Design tokens for the User-mode (light) UI, ported from the original
/// `auth` branch's `lib/theme/app_theme.dart` unchanged.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF6C3CE9); // deep violet
  static const Color primaryDark = Color(0xFF4A22B8);
  static const Color secondary = Color(0xFFFF5C8A); // warm rose
  static const Color sosStart = Color(0xFFFF4B6E);
  static const Color sosEnd = Color(0xFFC2185B);
  static const Color background = Color(0xFFF7F5FC);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF231B3B);
  static const Color textSecondary = Color(0xFF867F9B);
  static const Color success = Color(0xFF2FC28E);
  static const Color warning = Color(0xFFFFA94D);
  static const Color chipBackground = Color(0xFFF0EBFB);

  static const List<Color> heroGradient = [Color(0xFF7B2FF7), Color(0xFFB53FE0)];
  static const List<Color> sosGradient = [sosStart, sosEnd];
  static const List<Color> aiGradient = [Color(0xFF3F5EFB), Color(0xFF9C42F5)];
}

/// Reusable soft shadow used for floating cards / nav bars in User mode.
List<BoxShadow> softShadow({Color color = AppColors.primary, double opacity = 0.12}) {
  return [
    BoxShadow(
      color: color.withValues(alpha: opacity),
      blurRadius: 24,
      offset: const Offset(0, 10),
    ),
  ];
}