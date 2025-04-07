import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:flutter/material.dart';

/// {@template CDemoTile}
///
/// A tile that opens demo page when tapped.
///
/// {@endtemplate}
class CDemoTile extends StatelessWidget {
  /// {@macro CDemoTile}
  const CDemoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 24,
      title: Text(context.cAppL10n.settingsPage_demoTile_title),
      leading: const Icon(Icons.tips_and_updates_rounded),
      onTap: () => context.pushRoute(const CDemoRoute()),
    );
  }
}
