import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';

/// Titled, bordered card used for each block of the report detail screen.
class AdminSectionCard extends StatelessWidget {
  const AdminSectionCard({
    super.key,
    required this.palette,
    required this.title,
    required this.children,
  });

  final AppPalette palette;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: palette.textSecondary.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
              color: palette.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}

/// A label / value line inside an [AdminSectionCard].
class AdminInfoRow extends StatelessWidget {
  const AdminInfoRow({
    super.key,
    required this.palette,
    required this.label,
    required this.value,
  });

  final AppPalette palette;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: TextStyle(fontSize: 12, color: palette.textSecondary),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 13, color: palette.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
