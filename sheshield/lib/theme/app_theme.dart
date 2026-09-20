import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central design tokens for the SheShield app.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFF2E7E); // hot pink
  static const Color primaryDark = Color(0xFFC2185B); // deep rose
  static const Color secondary = Color(0xFFFF8FB3); // soft pink
  static const Color sosStart = Color(0xFFFF4B6E);
  static const Color sosEnd = Color(0xFFC2185B);
  static const Color background = Color(0xFFFFF8FB); // pale blush white
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF3B1330);
  static const Color textSecondary = Color(0xFF9E7A8C);
  static const Color success = Color(0xFF2FC28E);
  static const Color warning = Color(0xFFFFA94D);
  static const Color chipBackground = Color(0xFFFFE1EC);

  static const List<Color> heroGradient = [Color(0xFFFF6FA5), Color(0xFFFF2E7E)];
  static const List<Color> sosGradient = [sosStart, sosEnd];
  static const List<Color> aiGradient = [Color(0xFFFF6FB3), Color(0xFFB83280)];
  static const List<Color> helperGradient = [Color(0xFF3F5EFB), Color(0xFF7C3AED)];
}

class AppTheme {
  AppTheme._();

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

/// Reusable soft shadow used for floating cards / nav bars.
List<BoxShadow> softShadow({Color color = AppColors.primary, double opacity = 0.12}) {
  return [
    BoxShadow(
      color: color.withValues(alpha: opacity),
      blurRadius: 24,
      offset: const Offset(0, 10),
    ),
  ];
}
