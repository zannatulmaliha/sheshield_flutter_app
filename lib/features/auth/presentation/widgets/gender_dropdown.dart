import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/shared/entities/gender.dart';

/// Extracted from the signup form so that screen stays under the
/// project's 150-line-per-file limit, and so this becomes reusable if
/// gender ever needs editing elsewhere (e.g. a future profile screen).
class GenderDropdown extends ConsumerWidget {
  const GenderDropdown({super.key, required this.value, required this.onChanged});

  final Gender value;
  final ValueChanged<Gender?> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context)!;
    return DropdownButtonFormField<Gender>(
      initialValue: value,
      dropdownColor: colors.surface,
      style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: l10n.gender,
        labelStyle: TextStyle(color: colors.textSecondary),
        filled: true,
        fillColor: colors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      items: [
        DropdownMenuItem(value: Gender.female, child: Text(l10n.genderFemale)),
        DropdownMenuItem(value: Gender.male, child: Text(l10n.genderMale)),
        DropdownMenuItem(value: Gender.other, child: Text(l10n.genderOther)),
        DropdownMenuItem(
          value: Gender.preferNotToSay,
          child: Text(l10n.genderPreferNotToSay),
        ),
      ],
      onChanged: onChanged,
    );
  }
}
