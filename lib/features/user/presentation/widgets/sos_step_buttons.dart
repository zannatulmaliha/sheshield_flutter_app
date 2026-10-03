import 'package:flutter/material.dart';

/// Outlined secondary button shared by the SOS sheet steps.
class SosOutlinedStepButton extends StatelessWidget {
  const SosOutlinedStepButton({
    super.key,
    required this.label,
    required this.textColor,
    required this.onPressed,
    this.borderColor = const Color(0xFFE3DEF5),
  });

  final String label;
  final Color textColor;
  final Color borderColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: BorderSide(color: borderColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: onPressed,
      child: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w700)),
    );
  }
}

/// Filled primary button shared by the SOS sheet steps.
class SosFilledStepButton extends StatelessWidget {
  const SosFilledStepButton({
    super.key,
    required this.color,
    required this.onPressed,
    required this.child,
  });

  final Color color;
  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: onPressed,
      child: DefaultTextStyle.merge(
        style: const TextStyle(fontWeight: FontWeight.w800),
        child: child,
      ),
    );
  }
}
