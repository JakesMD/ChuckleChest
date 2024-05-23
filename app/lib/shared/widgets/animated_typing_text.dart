import 'dart:async';

import 'package:flutter/material.dart';

/// {@template CAnimatedTypingText}
///
/// A widget that animates text like a typewriter.
///
/// {@endtemplate}
class CAnimatedTypingText extends StatefulWidget {
  /// {@macro CAnimatedTypingText}
  const CAnimatedTypingText({
    required this.text,
    required this.textStyle,
    this.textAlign = TextAlign.start,
    this.onCompleted,
    this.speed = const Duration(milliseconds: 30),
    this.delay = const Duration(milliseconds: 1000),
    this.isAnimated = true,
    super.key,
  });

  /// The text to animate.
  final String text;

  /// The delay before the animation starts.
  final Duration delay;

  /// The speed of the animation.
  final Duration speed;

  /// A callback that is called when the animation is completed.
  final void Function()? onCompleted;

  /// Whether the animation is enabled.
  final bool isAnimated;

  /// The style of the text.
  final TextStyle textStyle;

  /// The alignment of the text.
  final TextAlign textAlign;

  @override
  State<CAnimatedTypingText> createState() => _CAnimatedTypingTextState();
}

class _CAnimatedTypingTextState extends State<CAnimatedTypingText>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController controller;
  late Animation<int> animation;
  late Timer delayTimer;

  @override
  void initState() {
    super.initState();

    if (!widget.isAnimated) {
      return WidgetsBinding.instance
          .addPostFrameCallback((_) => widget.onCompleted?.call());
    }

    controller = AnimationController(
      duration: widget.speed * widget.text.length,
      vsync: this,
    );

    animation = IntTween(begin: 0, end: widget.text.length).animate(controller)
      ..addListener(() => setState(() {}))
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) widget.onCompleted?.call();
        },
      );

    delayTimer = Timer(widget.delay, () => controller.forward());
  }

  @override
  void dispose() {
    if (widget.isAnimated) {
      controller.dispose();
      delayTimer.cancel();
    }
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (!widget.isAnimated) return Text(widget.text, style: widget.textStyle);

    return RichText(
      textAlign: widget.textAlign,
      text: TextSpan(
        children: [
          TextSpan(
            text: widget.text.substring(0, animation.value),
            style: widget.textStyle,
          ),
          TextSpan(
            text: widget.text.substring(animation.value, widget.text.length),
            style: widget.textStyle.copyWith(
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
