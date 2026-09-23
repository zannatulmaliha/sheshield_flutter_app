import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/shared/entities/gender.dart';
import 'package:sheshield/shared/entities/user_type.dart';

/// Lets a new account choose its role at signup.
/// Female accounts can choose User, Helper, or Both.
/// All other genders can only be a Helper.
class UserTypeSelector extends ConsumerWidget {
  const UserTypeSelector({
    super.key,
    required this.gender,
    required this.value,
    required this.onChanged,
  });

  final Gender gender;
  final UserType value;
  final ValueChanged<UserType> onChanged;

  List<(UserType, String, IconData)> _options(
    AppLocalizations l10n,
  ) {
    final all = [
      (
        UserType.user,
        l10n.roleAskForHelp,
        Icons.sos_rounded,
      ),
      (
        UserType.helper,
        l10n.roleRespondToAlerts,
        Icons.volunteer_activism_rounded,
      ),
      (
        UserType.userHelper,
        l10n.roleBoth,
        Icons.diversity_1_rounded,
      ),
    ];

    return gender == Gender.female
        ? all
        : all.where((option) => option.$1 == UserType.helper).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context)!;
    final options = _options(l10n);

    if (options.length == 1) {
      final (type, label, icon) = options.first;

      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: colors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: colors.primary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                l10n.onlyRoleAvailable(label),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colors.primary,
                  fontSize: 12.5,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final (type, label, icon) in options)
          ChoiceChip(
            selected: value == type,
            onSelected: (_) => onChanged(type),
            avatar: Icon(
              icon,
              size: 16,
            ),
            label: Text(label),
            backgroundColor: colors.surface,
            selectedColor: colors.primary,
            labelStyle: TextStyle(
              color: value == type ? Colors.white : colors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
      ],
    );
  }
}
