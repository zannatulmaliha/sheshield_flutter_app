import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme_mode.dart';
import 'package:sheshield/features/settings/presentation/providers/theme_mode_provider.dart';

Future<void> showThemeModePickerSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => const _ThemeModePickerSheet(),
  );
}

class _ThemeModePickerSheet extends ConsumerWidget {
  const _ThemeModePickerSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final colors = resolvePalette(context, ref);
    final current = ref.watch(themeModeControllerProvider).valueOrNull ?? AppThemeMode.system;

    final options = [
      (AppThemeMode.system, l10n.themeSystem, Icons.brightness_auto_rounded),
      (AppThemeMode.light, l10n.themeLight, Icons.light_mode_rounded),
      (AppThemeMode.dark, l10n.themeDark, Icons.dark_mode_rounded),
    ];

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.18), blurRadius: 24, offset: const Offset(0, 10)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.chooseTheme,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: colors.textPrimary),
            ),
            const SizedBox(height: 12),
            for (final (mode, label, icon) in options)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(icon, color: colors.textSecondary),
                title: Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: colors.textPrimary)),
                trailing: current == mode ? Icon(Icons.check_circle_rounded, color: colors.primary) : null,
                onTap: () {
                  ref.read(themeModeControllerProvider.notifier).setMode(mode);
                  Navigator.of(context).pop();
                },
              ),
          ],
        ),
      ),
    );
  }
}
