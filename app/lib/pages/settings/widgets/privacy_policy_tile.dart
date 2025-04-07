import 'package:chuckle_chest/localization/l10n.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// {@template CPrivacyPolicyTile}
///
/// A tile that opens the privacy policy page when tapped.
///
/// {@endtemplate}
class CPrivacyPolicyTile extends StatelessWidget {
  /// {@macro CPrivacyPolicyTile}
  const CPrivacyPolicyTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 24,
      title: Text(context.cAppL10n.settingsPage_privacyPolicyTile_title),
      leading: const Icon(Icons.privacy_tip_rounded),
      onTap: () => launchUrl(Uri.parse('https://chucklechest.app/privacy')),
    );
  }
}
