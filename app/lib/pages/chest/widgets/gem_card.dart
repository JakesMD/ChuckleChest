import 'package:ccore/ccore.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/shared/widgets/animated_gem.dart';
import 'package:flutter/material.dart';

/// {@template CGemCard}
///
/// A card that displays a gem.
///
/// {@endtemplate}
class CGemCard extends StatelessWidget {
  /// {@macro CGemCard}
  const CGemCard({
    required this.gem,
    this.onPressed,
    super.key,
  });

  /// The gem to display.
  final CGem gem;

  /// Called when the card is pressed.
  final void Function(CGem gem)? onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => onPressed?.call(gem),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    gem.number.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    gem.occurredAt.cLocalize(
                      context,
                      dateFormat: CDateFormat.yearMonth,
                    ),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(12),
              child: CAnimatedGem(gem: gem, isAnimated: false),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share_rounded),
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
