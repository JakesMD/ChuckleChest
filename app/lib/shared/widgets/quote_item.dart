import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:cpub/signed_spacing_flex.dart';
import 'package:flutter/material.dart';

/// {@template CQuoteItem}
///
/// A widget that displays a line.
///
/// {@endtemplate}
class CQuoteItem extends StatelessWidget {
  /// {@macro CQuoteItem}
  const CQuoteItem({
    required this.line,
    required this.person,
    required this.occurredAt,
    this.onAnimationCompleted,
    this.isAnimated = true,
    super.key,
  });

  /// The line to display.
  final CLine line;

  /// The person who said the line.
  final CPerson person;

  /// The date the line occurred.
  final DateTime occurredAt;

  /// The callback when the animation is completed.
  final void Function()? onAnimationCompleted;

  /// Whether the animation is enabled.
  final bool isAnimated;

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
                      person.nickname,
                      person.ageAtDate(occurredAt),
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  CAnimatedLine(
                    isAnimated: isAnimated,
                    text: line.text,
                    onCompleted: onAnimationCompleted,
                    textStyle: Theme.of(context).textTheme.bodyLarge!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
