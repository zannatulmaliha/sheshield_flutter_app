import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A one-shot burst of falling, fading particles used to celebrate a
/// level-up.
class ConfettiBurst extends StatefulWidget {
  const ConfettiBurst({super.key, this.particleCount = 26});

  final int particleCount;

  @override
  State<ConfettiBurst> createState() => _ConfettiBurstState();
}

class _ConfettiBurstState extends State<ConfettiBurst> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Particle> _particles;

  static const _colors = [
    Color(0xFFFF2E7E),
    Color(0xFFFFD166),
    Color(0xFF3F5EFB),
    Color(0xFF2FC28E),
    Colors.white,
  ];

  @override
  void initState() {
    super.initState();
    final rnd = math.Random(7);
    _particles = List.generate(widget.particleCount, (i) {
      return _Particle(
        angle: rnd.nextDouble() * 2 * math.pi,
        distance: 90 + rnd.nextDouble() * 140,
        size: 5 + rnd.nextDouble() * 7,
        color: _colors[rnd.nextInt(_colors.length)],
        delay: rnd.nextDouble() * 0.25,
      );
    });
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100))..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _ConfettiPainter(_particles, _controller.value),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _Particle {
  _Particle({
    required this.angle,
    required this.distance,
    required this.size,
    required this.color,
    required this.delay,
  });

  final double angle;
  final double distance;
  final double size;
  final Color color;
  final double delay;
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter(this.particles, this.progress);

  final List<_Particle> particles;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.32);
    for (final p in particles) {
      final t = ((progress - p.delay) / (1 - p.delay)).clamp(0.0, 1.0);
      final eased = Curves.easeOutCubic.transform(t);
      final fall = Curves.easeIn.transform(t) * 60;
      final offset = Offset(
        center.dx + math.cos(p.angle) * p.distance * eased,
        center.dy + math.sin(p.angle) * p.distance * eased + fall,
      );
      final opacity = (1 - t).clamp(0.0, 1.0);
      final paint = Paint()..color = p.color.withValues(alpha: opacity);
      canvas.drawCircle(offset, p.size * (1 - t * 0.3), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => oldDelegate.progress != progress;
}
