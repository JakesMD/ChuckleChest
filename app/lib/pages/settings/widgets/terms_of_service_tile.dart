import 'package:chuckle_chest/localization/l10n.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// {@template CTermsOfServiceTile}
///
/// A tile that opens the privacy policy page when tapped.
///
/// {@endtemplate}
class CTermsOfServiceTile extends StatelessWidget {
  /// {@macro CTermsOfServiceTile}
  const CTermsOfServiceTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 24,
      title: Text(context.cAppL10n.settingsPage_termsOfServiceTile_title),
      leading: const Icon(Icons.assignment_rounded),
      onTap: () => launchUrl(Uri.parse('https://chucklechest.app/terms')),
    );
  }
}
