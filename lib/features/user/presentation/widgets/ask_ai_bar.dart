import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';

/// Search-bar lookalike that opens the Ask AI Guardian chat.
class AskAiBar extends StatelessWidget {
  const AskAiBar({super.key, required this.palette, required this.onTap});

  final AppPalette palette;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: softShadow(opacity: 0.07),
        ),
        child: Row(
          children: [
            Icon(Icons.auto_awesome_rounded, color: palette.primary, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Ask AI Guardian anything...',
                style: TextStyle(
                  color: palette.textSecondary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            IconButton(
              onPressed: onTap,
              icon: Icon(Icons.mic_rounded, color: palette.primary),
            ),
          ],
        ),
      ),
    );
  }
}
