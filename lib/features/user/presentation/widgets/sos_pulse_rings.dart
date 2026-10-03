import 'package:flutter/material.dart';

/// Two expanding, fading rings behind the SOS button, driven by [animation]
/// (0..1, repeating).
class SosPulseRings extends StatelessWidget {
  const SosPulseRings({
    super.key,
    required this.animation,
    required this.buttonSize,
    required this.color,
  });

  static const _ringCount = 2;

  final Animation<double> animation;
  final double buttonSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => Stack(
        alignment: Alignment.center,
        children: [
          for (var ring = 0; ring < _ringCount; ring++)
            _Ring(
              progress: (animation.value + ring / _ringCount) % 1.0,
              buttonSize: buttonSize,
              color: color,
            ),
        ],
      ),
    );
  }
}

class _Ring extends StatelessWidget {
  const _Ring({required this.progress, required this.buttonSize, required this.color});

  final double progress;
  final double buttonSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final diameter = buttonSize + buttonSize * 0.7 * progress;

    return Opacity(
      opacity: (1 - progress) * 0.35,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}
