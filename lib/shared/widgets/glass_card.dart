import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';

/// A frosted glass panel that lets whatever's behind it (typically
/// [AuroraBackground]) show through -- used for hero moments. Tints its
/// glass from the current [AppPalette.surface] rather than a hardcoded
/// white, so it still reads correctly against a dark background.
class GlassCard extends ConsumerWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 28,
    this.padding = const EdgeInsets.all(20),
  });

  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = resolvePalette(context, ref);
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: colors.surface.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: colors.surface.withValues(alpha: 0.65), width: 1.2),
          ),
          child: child,
        ),
      ),
    );
  }
}
