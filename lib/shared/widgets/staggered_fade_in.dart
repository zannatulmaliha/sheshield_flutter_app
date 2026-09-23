import 'package:flutter/material.dart';

/// Fades and slides its [children] in one after another, staggered by
/// [itemDelay]. Used to give each screen a lively entrance.
class StaggeredFadeIn extends StatefulWidget {
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
  State<StaggeredFadeIn> createState() => _StaggeredFadeInState();
}

class _StaggeredFadeInState extends State<StaggeredFadeIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final int _totalMs;

  @override
  void initState() {
    super.initState();
    _totalMs = widget.itemDelay.inMilliseconds * widget.children.length + widget.itemDuration.inMilliseconds;
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: _totalMs))..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(widget.children.length, (i) {
        final startMs = widget.itemDelay.inMilliseconds * i;
        final endMs = startMs + widget.itemDuration.inMilliseconds;
        final interval = Interval(
          (startMs / _totalMs).clamp(0.0, 1.0),
          (endMs / _totalMs).clamp(0.0, 1.0),
          curve: Curves.easeOutCubic,
        );
        final animation = CurvedAnimation(parent: _controller, curve: interval);
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(animation),
            child: widget.children[i],
          ),
        );
      }),
    );
  }
}
