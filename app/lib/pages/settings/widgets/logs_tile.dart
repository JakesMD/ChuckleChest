import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:flutter/material.dart';

/// {@template CLogsTile}
///
/// The tile on the settings page that navigates to the logs page.
///
/// {@endtemplate}
class CLogsTile extends StatelessWidget {
  /// {@macro CLogsTile}
  const CLogsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 24,
      leading: const Icon(Icons.developer_mode_rounded),
      title: Text(context.cAppL10n.settingsPage_logsTile_title),
      onTap: () => context.router.push(const CLogsRoute()),
    );
  }
}
