import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';

class ContactsCoverageBanner extends StatelessWidget {
  const ContactsCoverageBanner({super.key, required this.palette});

  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.chipBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: palette.primary, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Add at least 3 contacts for reliable emergency coverage.',
              style: TextStyle(
                color: palette.primaryDark,
                fontWeight: FontWeight.w600,
                fontSize: 12.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
