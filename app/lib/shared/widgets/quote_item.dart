import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:cpub/signed_spacing_flex.dart';
import 'package:flutter/material.dart';

/// {@template CQuoteItem}
///
/// A widget that displays a quote.
///
/// {@endtemplate}
class CQuoteItem extends StatelessWidget {
  /// {@macro CQuoteItem}
  const CQuoteItem({
    required this.quote,
    this.onAnimationCompleted,
    bool? isAnimated,
    this.isEditable = false,
    super.key,
  }) : isAnimated = isAnimated ?? !isEditable;

  /// The quote to display.
  final CQuote quote;

  /// The callback when the animation is completed.
  final void Function()? onAnimationCompleted;

  /// Whether the animation is enabled.
  final bool isAnimated;

  /// Whether the quote is editable.
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
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            const CircleAvatar(
              minRadius: 20,
              maxRadius: 20,
              child: Icon(Icons.person_rounded),
            ),
            Expanded(
              child: SignedSpacingColumn(
                spacing: 4,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    CAppL10n.of(context).quoteItem_person(
                      quote.nickname,
                      quote.age,
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  CAnimatedLine(
                    isAnimated: isAnimated,
                    text: quote.text,
                    onCompleted: onAnimationCompleted,
                    textStyle: Theme.of(context).textTheme.bodyLarge!,
                  ),
                ],
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
