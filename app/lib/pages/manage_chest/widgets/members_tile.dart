import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:flutter/material.dart';

/// {@template CMembersTile}
///
/// The tile on the manage chest page that navigates to the members page.
///
/// {@endtemplate}
class CMembersTile extends StatelessWidget {
  /// {@macro CMembersTile}
  const CMembersTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 24,
      leading: const Icon(Icons.groups_rounded),
      title: Text(context.cAppL10n.manageChestPage_membersTile_title),
      onTap: () => context.router.push(const CMembersRoute()),
    );
  }
}
