import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';

/// A softly drifting mesh-gradient background -- the "background image" for
/// User-mode screens, generated in code so it always renders crisply
/// offline with no external asset or licensing dependency.
class AuroraBackground extends ConsumerStatefulWidget {
  const AuroraBackground({super.key});

  @override
  ConsumerState<AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends ConsumerState<AuroraBackground> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 16))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = resolvePalette(context, ref);
    final size = MediaQuery.sizeOf(context);
    return Positioned.fill(
      child: ColoredBox(
        color: colors.background,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final t = _controller.value * 2 * math.pi;
            return Stack(
              children: [
                _Blob(
                  top: -size.width * 0.38 + math.sin(t) * 20,
                  left: -size.width * 0.32 + math.cos(t) * 16,
                  diameter: size.width * 1.15,
                  colors: [colors.primary.withValues(alpha: 0.14), Colors.transparent],
                ),
                _Blob(
                  top: size.height * 0.22 + math.cos(t * 0.8) * 22,
                  right: -size.width * 0.38 + math.sin(t * 0.8) * 18,
                  diameter: size.width * 0.95,
                  colors: [colors.secondary.withValues(alpha: 0.14), Colors.transparent],
                ),
                _Blob(
                  bottom: -size.width * 0.32 + math.sin(t * 1.3) * 18,
                  left: size.width * 0.1 + math.cos(t * 1.1) * 20,
                  diameter: size.width * 0.9,
                  colors: const [Color(0xFFE87FB0), Colors.transparent],
                  opacity: 0.14,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({
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
