import 'package:flutter/material.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/router/app_router.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';

/// Logo, app name and welcome line. Long-pressing the logo opens the
/// (deliberately hidden) admin sign-in.
class LoginBrandHeader extends StatelessWidget {
  const LoginBrandHeader({super.key, required this.palette, required this.l10n});

  final AppPalette palette;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onLongPress: () => const AdminLoginRoute().push(context),
          child: Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: palette.heroGradient),
              boxShadow: softShadow(color: palette.primary, opacity: 0.3),
            ),
            child: const Icon(Icons.shield_rounded, color: Colors.white, size: 40),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          l10n.appName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: palette.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l10n.welcomeBack,
          textAlign: TextAlign.center,
          style: TextStyle(color: palette.textSecondary, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
