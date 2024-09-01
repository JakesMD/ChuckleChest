import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';

/// {@template CNarrationItem}
///
/// A widget that displays a line.
///
/// {@endtemplate}
class CNarrationItem extends StatelessWidget {
  /// {@macro CNarrationItem}
  const CNarrationItem({
    required this.line,
    this.onAnimationCompleted,
    this.isAnimated = true,
    super.key,
  });

  /// The line to display.
  final CLine line;

  /// The callback when the animation is completed.
  final void Function()? onAnimationCompleted;

  /// Whether the animation is enabled.
  ///
  /// Defaults to true.
  final bool isAnimated;

  @override
  Widget build(BuildContext context) {
    return CFadeIn(
      isAnimated: isAnimated,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: CAnimatedLine(
          isAnimated: isAnimated,
          text: line.text,
          onCompleted: onAnimationCompleted,
          textStyle: Theme.of(context).textTheme.bodyLarge!,
        ),
      ),
    );
  }
}
