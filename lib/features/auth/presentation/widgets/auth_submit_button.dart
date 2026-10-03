import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';

/// Full-width primary button that swaps its label for a spinner while the
/// action runs.
class AuthSubmitButton extends StatelessWidget {
  const AuthSubmitButton({
    super.key,
    required this.label,
    required this.isLoading,
    required this.palette,
    required this.onPressed,
  });

  final String label;
  final bool isLoading;
  final AppPalette palette;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: palette.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            )
          : Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
    );
  }
}
