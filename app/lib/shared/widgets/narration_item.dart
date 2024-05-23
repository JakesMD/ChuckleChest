import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:cpub/signed_spacing_flex.dart';
import 'package:flutter/material.dart';

/// {@template CNarrationItem}
///
/// A widget that displays a narration.
///
/// {@endtemplate}
class CNarrationItem extends StatelessWidget {
  /// {@macro CNarrationItem}
  const CNarrationItem({
    required this.narration,
    this.onAnimationCompleted,
    bool? isAnimated,
    this.isEditable = false,
    super.key,
  }) : isAnimated = isAnimated ?? !isEditable;

  /// The narration to display.
  final CNarration narration;

  /// The callback when the animation is completed.
  final void Function()? onAnimationCompleted;

  /// Whether the animation is enabled.
  ///
  /// Defaults to true if [isEditable] is false.
  final bool isAnimated;

  /// Whether the narration is editable.
  ///
  /// If true, an edit button is displayed.
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return CFadeIn(
      isAnimated: isAnimated,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SignedSpacingRow(
          spacing: 16,
          children: [
            Expanded(
              child: CAnimatedLine(
                isAnimated: isAnimated,
                text: narration.text,
                onCompleted: onAnimationCompleted,
                textStyle: Theme.of(context).textTheme.bodyLarge!,
              ),
            ),
            if (isEditable)
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit_rounded),
              ),
          ],
        ),
      ),
    );
  }
}
