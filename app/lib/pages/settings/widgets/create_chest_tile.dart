import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:flutter/material.dart';

/// {@template CCreateChestTile}
///
/// The tile on the settings page that allows the user to create a new chest of
/// their own.
///
/// {@endtemplate}
class CCreateChestTile extends StatelessWidget {
  /// {@macro CCreateChestTile}
  const CCreateChestTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 24,
      leading: const Icon(Icons.add_rounded),
      title: Text(context.cAppL10n.settingsPage_createChestTile_title),
      onTap: () => context.pushRoute(CCreateChestRoute()),
    );
  }
}
