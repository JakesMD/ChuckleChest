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
    return MaterialBanner(
      content: Text(context.cAppL10n.changesPropagationBanner_message),
      leading: const Icon(Icons.info_rounded),
      actions: [Container()],
    );
  }
}
