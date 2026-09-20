import 'package:flutter/material.dart';
import '../../models/gender.dart';
import '../../models/user_type.dart';
import '../../theme/app_theme.dart';

/// Shows chips for whichever [UserType]s [allowedUserTypesFor] returns for
/// the current gender. When gender isn't female there's only one option
/// (Helper), so this renders as an explanatory, non-interactive notice
/// instead of a picker — nothing to choose means nothing to tap.
class RoleSelector extends StatelessWidget {
  const RoleSelector({
    super.key,
    required this.gender,
    required this.value,
    required this.onChanged,
  });

  final Gender gender;
  final UserType value;
  final ValueChanged<UserType> onChanged;

  @override
  Widget build(BuildContext context) {
    final options = allowedUserTypesFor(gender);

    if (options.length == 1) {
      return Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: AppColors.chipBackground,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(Icons.volunteer_activism_rounded, color: AppColors.primary, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "You'll sign up as a Helper — SheShield's user role is for women.",
                style: const TextStyle(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.5,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Wrap(
        spacing: 10,
        children: options.map((type) {
          final selected = type == value;
          return ChoiceChip(
            label: Text(type.label),
            selected: selected,
            onSelected: (_) => onChanged(type),
            labelStyle: TextStyle(
              color: selected ? Colors.white : AppColors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
            selectedColor: AppColors.primary,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: selected ? AppColors.primary : const Color(0xFFE3DEF5)),
            ),
          );
        }).toList(),
      ),
    );
  }
}
