import 'package:flutter/material.dart';

/// One soft radial-gradient circle of the aurora.
class AuroraBlob extends StatelessWidget {
  const AuroraBlob({
    super.key,
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.diameter,
    required this.colors,
    this.opacity = 1,
  });

  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double diameter;
  final List<Color> colors;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(colors: colors),
          ),
        ),
      ),
    );
  }
}
