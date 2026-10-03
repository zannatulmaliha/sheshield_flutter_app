import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Fades and slides its [children] in one after another, staggered by
/// [itemDelay]. Gives each screen a lively entrance.
class StaggeredFadeIn extends HookWidget {
  const StaggeredFadeIn({
    super.key,
    required this.children,
    this.itemDelay = const Duration(milliseconds: 70),
    this.itemDuration = const Duration(milliseconds: 450),
  });

  final List<Widget> children;
  final Duration itemDelay;
  final Duration itemDuration;

  @override
  Widget build(BuildContext context) {
    final totalMilliseconds =
        itemDelay.inMilliseconds * children.length + itemDuration.inMilliseconds;
    final controller = useAnimationController(
      duration: Duration(milliseconds: totalMilliseconds),
    );

    useEffect(() {
      controller.forward();
      return null;
    }, [controller],);

    Animation<double> animationForItem(int index) {
      final startMilliseconds = itemDelay.inMilliseconds * index;
      final endMilliseconds = startMilliseconds + itemDuration.inMilliseconds;
      return CurvedAnimation(
        parent: controller,
        curve: Interval(
          (startMilliseconds / totalMilliseconds).clamp(0.0, 1.0),
          (endMilliseconds / totalMilliseconds).clamp(0.0, 1.0),
          curve: Curves.easeOutCubic,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final (index, child) in children.indexed)
          _FadeSlideIn(animation: animationForItem(index), child: child),
      ],
    );
  }
}

class _FadeSlideIn extends StatelessWidget {
  const _FadeSlideIn({required this.animation, required this.child});

  static final _slideTween = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero);

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(position: _slideTween.animate(animation), child: child),
    );
  }
}
