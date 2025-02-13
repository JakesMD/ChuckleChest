import 'package:chuckle_chest/localization/l10n.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// {@template CContactTile}
///
/// A tile that opens the contact page when tapped.
///
/// {@endtemplate}
class CContactTile extends StatelessWidget {
  /// {@macro CContactTile}
  const CContactTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(context.cAppL10n.settingsPage_contactTile_title),
      leading: const Icon(Icons.contact_page_rounded),
      onTap: () => launchUrl(Uri.parse('https://chucklechest.app/contact')),
    );
  }
}
