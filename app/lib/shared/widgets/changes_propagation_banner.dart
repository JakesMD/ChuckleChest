import 'package:chuckle_chest/localization/l10n.dart';
import 'package:flutter/material.dart';

/// {@template CChangesPropagationBanner}
///
/// A banner that informs the user how changes are propagated to other users.
///
/// {@endtemplate}
class CChangesPropagationBanner extends StatelessWidget {
  /// {@macro CChangesPropagationBanner}
  const CChangesPropagationBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      padding: const EdgeInsets.all(16),
      child: Row(
        spacing: 16,
        children: [
          Icon(
            Icons.info_rounded,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          Expanded(
            child: Text(
              context.cAppL10n.changesPropagationBanner_message,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
