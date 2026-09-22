import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/l10n/app_language.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/settings/presentation/providers/locale_provider.dart';

Future<void> showLanguagePickerSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => const _LanguagePickerSheet(),
  );
}

class _LanguagePickerSheet extends ConsumerWidget {
  const _LanguagePickerSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final current = ref.watch(localeControllerProvider).valueOrNull;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: softShadow(opacity: 0.18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.chooseLanguage,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 12),
            for (final language in AppLanguage.values)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(language.nativeName, style: const TextStyle(fontWeight: FontWeight.w600)),
                trailing: current == language ? const Icon(Icons.check_circle_rounded, color: AppColors.primary) : null,
                onTap: () {
                  ref.read(localeControllerProvider.notifier).setLanguage(language);
                  Navigator.of(context).pop();
                },
              ),
          ],
        ),
      ),
    );
  }
}