import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';

/// {@template CAnimatedLine}
///
/// A widget that animates text like a typewriter.
///
/// {@endtemplate}
class CAnimatedLine extends StatelessWidget {
  /// {@macro CAnimatedLine}
  const CAnimatedLine({
    required this.text,
    required this.textStyle,
    this.onCompleted,
    this.speed = const Duration(milliseconds: 30),
    this.delay = const Duration(milliseconds: 1500),
    this.sizeAnimationDuration = const Duration(milliseconds: 250),
    this.sizeAnimationCurve = Curves.easeOut,
    this.isAnimated = true,
    super.key,
  });

  /// The text to animate.
  final String text;

  /// The delay before the animation starts.
  final Duration delay;

  /// The speed of the animation.
  final Duration speed;

  /// The duration of the size animation.
  final Duration sizeAnimationDuration;

  /// The curve of the size animation.
  final Curve sizeAnimationCurve;

  /// A callback that is called when the animation is completed.
  final void Function()? onCompleted;

  /// Whether the animation is enabled.
  final bool isAnimated;

  /// A function that builds the text widget.
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: Alignment.topLeft,
      clipBehavior: Clip.none,
      duration: sizeAnimationDuration,
      curve: sizeAnimationCurve,
      child: LayoutBuilder(
        builder: (context, constraints) => SizedBox(
          width: constraints.maxWidth,
          child: CAnimatedTypingText(
            text: text,
            textStyle: textStyle,
            onCompleted: onCompleted,
            speed: speed,
            delay: delay,
            isAnimated: isAnimated,
          ),
        ),
      ),
    );
  }
}
