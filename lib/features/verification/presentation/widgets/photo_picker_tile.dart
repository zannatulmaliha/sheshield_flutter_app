import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';

/// One of the three photo slots on the verification screen. Shows the
/// picked image, or an empty state with an icon and hint.
class PhotoPickerTile extends StatelessWidget {
  const PhotoPickerTile({
    super.key,
    required this.colors,
    required this.label,
    required this.hint,
    required this.icon,
    required this.bytes,
    required this.onTap,
  });

  final AppPalette colors;
  final String label;
  final String hint;
  final IconData icon;
  final Uint8List? bytes;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final picked = bytes != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: picked ? colors.success : const Color(0xFFE3DEF5),
            width: picked ? 2 : 1.5,
          ),
        ),
        child: picked ? _preview(context) : _empty(),
      ),
    );
  }

  Widget _preview(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.memory(bytes!, fit: BoxFit.cover),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('$label · tap to change',
                style: const TextStyle(color: Colors.white, fontSize: 11.5, fontWeight: FontWeight.w700)),
          ),
        ),
      ],
    );
  }

  Widget _empty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 32, color: colors.primary),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: colors.textPrimary)),
        const SizedBox(height: 3),
        Text(hint, style: TextStyle(fontSize: 11.5, color: colors.textSecondary)),
      ],
    );
  }
}
