import 'package:chuckle_chest/localization/l10n.dart';
import 'package:flutter/material.dart';

/// {@template CLicensesTile}
///
/// A tile that displays opens the licenses page when tapped.
///
/// {@endtemplate}
class CLicensesTile extends StatelessWidget {
  /// {@macro CLicensesTile}
  const CLicensesTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(context.cAppL10n.settingsPage_licensesTile_title),
      leading: const Icon(Icons.verified_rounded),
      onTap: () => showLicensePage(context: context),
    );
  }
}
