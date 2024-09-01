import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:flutter/material.dart';

/// {@template CAnimatedGem}
///
/// A widget that displays an animated gem.
///
/// {@endtemplate}
class CAnimatedGem extends StatefulWidget {
  /// {@macro CAnimatedGem}
  const CAnimatedGem({
    required this.gem,
    required this.isAnimated,
    super.key,
  });

  /// The gem to display.
  final CGem gem;

  /// Whether the animation is enabled.
  final bool isAnimated;

  @override
  State<CAnimatedGem> createState() => _CAnimatedGemState();
}

class _CAnimatedGemState extends State<CAnimatedGem> {
  int currentLineIndex = 0;

  void onLineAnimationCompleted() {
    if (!widget.isAnimated) return;
    if (currentLineIndex == widget.gem.lines.length - 1) return;
    setState(() => currentLineIndex++);
  }

  @override
  Widget build(BuildContext context) {
    final lines = widget.isAnimated
        ? widget.gem.lines.sublist(0, currentLineIndex + 1)
        : widget.gem.lines;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: lines.isNotEmpty
          ? [
              for (final line in lines)
                if (line.personID == null)
                  CNarrationItem(
                    line: line,
                    onAnimationCompleted: onLineAnimationCompleted,
                    isAnimated: widget.isAnimated,
                  )
                else
                  CQuoteItem(
                    line: line,
                    occurredAt: widget.gem.occurredAt,
                    person: CPerson(
                      id: BigInt.one,
                      nickname: 'Lydia',
                      dateOfBirth: DateTime(2001),
                      avatarURLs: [],
                    ),
                    onAnimationCompleted: onLineAnimationCompleted,
                    isAnimated: widget.isAnimated,
                  ),
            ]
          : [],
    );
  }
}
