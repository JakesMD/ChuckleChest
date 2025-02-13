import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:flutter/material.dart';

/// {@template CManageChestTile}
///
/// The tile on the settings page that navigates to the manage chest page.
///
/// {@endtemplate}
class CManageChestTile extends StatelessWidget {
  /// {@macro CManageChestTile}
  const CManageChestTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 16,
      leading: const Icon(Icons.manage_accounts_rounded),
      title: Text(context.cAppL10n.settingsPage_manageChestTile_title),
      onTap: () => context.router.push(const CManageChestRoute()),
    );
  }
}
