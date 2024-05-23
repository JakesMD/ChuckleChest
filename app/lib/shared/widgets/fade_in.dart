import 'dart:async';

import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';

/// {@template CFadeIn}
///
/// A widget that fades and slides in a child widget.
///
/// {@endtemplate}
class CFadeIn extends StatefulWidget {
  /// {@macro CFadeIn}
  const CFadeIn({
    required this.child,
    this.delay = const Duration(milliseconds: 500),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOut,
    this.slideOffset = const Offset(0, 0.25),
    this.isAnimated = true,
    super.key,
  });

  /// The delay before the animation starts.
  final Duration delay;

  /// The duration of the animation.
  final Duration duration;

  /// The curve of the animation.
  final Curve curve;

  /// The offset to slide the widget from.
  final Offset slideOffset;

  /// Whether the animation is enabled.
  final bool isAnimated;

  /// The widget to animate.
  final Widget child;

  @override
  State<CFadeIn> createState() => _CFadeInState();
}

class _CFadeInState extends State<CFadeIn>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController controller;
  late Animation<double> sizeAnimation;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;
  late Timer delayTimer;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);

    sizeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: widget.curve),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller, curve: widget.curve),
    );

    slideAnimation =
        Tween<Offset>(begin: widget.slideOffset, end: Offset.zero).animate(
      CurvedAnimation(parent: controller, curve: widget.curve),
    );

    if (widget.isAnimated) {
      delayTimer = Timer(widget.delay, () => controller.forward());
    }
  }

  @override
  void dispose() {
    if (widget.isAnimated) delayTimer.cancel();

    controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (!widget.isAnimated) return widget.child;

    return CSizeTransition(
      sizeFactor: sizeAnimation,
      axisAlignment: -1,
      clipBehavior: Clip.none,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: widget.child,
        ),
      ),
    );
  }
}
