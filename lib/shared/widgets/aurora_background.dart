import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/shared/widgets/aurora_blob.dart';

/// A softly drifting mesh-gradient background: the "background image" for
/// User-mode screens, generated in code so it always renders crisply
/// offline with no external asset or licensing dependency.
class AuroraBackground extends HookConsumerWidget {
  const AuroraBackground({super.key});

  static const _driftDuration = Duration(seconds: 16);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final size = MediaQuery.sizeOf(context);
    final controller = useAnimationController(duration: _driftDuration);

    useEffect(() {
      controller.repeat();
      return null;
    }, [controller],);

    return Positioned.fill(
      child: ColoredBox(
        color: palette.background,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            final angle = controller.value * 2 * math.pi;
            return Stack(
              children: [
                AuroraBlob(
                  top: -size.width * 0.38 + math.sin(angle) * 20,
                  left: -size.width * 0.32 + math.cos(angle) * 16,
                  diameter: size.width * 1.15,
                  colors: [palette.primary.withValues(alpha: 0.14), Colors.transparent],
                ),
                AuroraBlob(
                  top: size.height * 0.22 + math.cos(angle * 0.8) * 22,
                  right: -size.width * 0.38 + math.sin(angle * 0.8) * 18,
                  diameter: size.width * 0.95,
                  colors: [palette.secondary.withValues(alpha: 0.14), Colors.transparent],
                ),
                AuroraBlob(
                  bottom: -size.width * 0.32 + math.sin(angle * 1.3) * 18,
                  left: size.width * 0.1 + math.cos(angle * 1.1) * 20,
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
