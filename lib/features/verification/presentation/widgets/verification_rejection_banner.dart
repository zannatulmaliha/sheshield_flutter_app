import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';

class VerificationRejectionBanner extends StatelessWidget {
  const VerificationRejectionBanner({
    super.key,
    required this.palette,
    required this.reviewerNote,
  });

  final AppPalette palette;
  final String reviewerNote;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: palette.sosEnd.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        'Not approved: $reviewerNote\nYou can send new photos below.',
        style: TextStyle(color: palette.textPrimary, fontSize: 13),
      ),
    );
  }
}
