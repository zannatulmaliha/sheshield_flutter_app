import 'package:flutter/material.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/shared/entities/gender.dart';

/// Extracted from the signup form so that screen stays under the
/// project's 150-line-per-file limit, and so this becomes reusable if
/// gender ever needs editing elsewhere (e.g. a future profile screen).
class GenderDropdown extends StatelessWidget {
  const GenderDropdown({super.key, required this.value, required this.onChanged});

  final Gender value;
  final ValueChanged<Gender?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return DropdownButtonFormField<Gender>(
      initialValue: value,
      dropdownColor: const Color(0xFF1E1B4B),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: l10n.gender,
        labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.06),
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
