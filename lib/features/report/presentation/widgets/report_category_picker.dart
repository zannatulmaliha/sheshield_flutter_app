import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/report/domain/entities/report_category.dart';

/// Radio list of every [ReportCategory]; stateless -- the parent owns the
/// selection.
class ReportCategoryPicker extends StatelessWidget {
  const ReportCategoryPicker({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.palette,
  });

  final ReportCategory? selectedCategory;
  final ValueChanged<ReportCategory?> onCategoryChanged;
  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return RadioGroup<ReportCategory>(
      groupValue: selectedCategory,
      onChanged: onCategoryChanged,
      child: Column(
        children: [
          for (final category in ReportCategory.values)
            RadioListTile<ReportCategory>(
              contentPadding: EdgeInsets.zero,
              value: category,
              activeColor: palette.primary,
              title: Text(
                category.label,
                style: TextStyle(
                  color: palette.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
