import 'package:flutter/material.dart';
import '../../models/gender.dart';
import '../../theme/app_theme.dart';

class GenderDropdown extends StatelessWidget {
  const GenderDropdown({super.key, required this.value, required this.onChanged});

  final Gender value;
  final ValueChanged<Gender?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<Gender>(
        // Controlled by the parent's setState — must be `value`, not
        // `initialValue`, so re-selecting gender actually updates the
        // rendered dropdown on every rebuild.
        value: value,
        style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          labelText: 'Gender',
          labelStyle: const TextStyle(color: AppColors.textSecondary),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
        items: Gender.values
            .map((g) => DropdownMenuItem(value: g, child: Text(g.label)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
