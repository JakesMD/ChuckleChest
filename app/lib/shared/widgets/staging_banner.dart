import 'package:chuckle_chest/app/app.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// {@template CStagingBanner}
///
/// A banner that is displayed when the app is in staging mode.
///
/// It warns the user that the app is in staging mode and provides a button to
/// open the production website.
///
/// {@endtemplate}
class CStagingBanner extends StatelessWidget {
  /// {@macro CStagingBanner}
  const CStagingBanner({required this.appFlavor, super.key});

  /// The current app flavor.
  final CAppFlavor appFlavor;

  // coverage:ignore-start
  Future<void> _openProductionWebsite() async {
    await launchUrl(Uri.parse('https://github.com/JakesMD/ChuckleChest/'));
  }
  // coverage:ignore-end

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: appFlavor == CAppFlavor.staging,
      child: MaterialBanner(
        leading: const Icon(Icons.construction_rounded),
        content: Text(context.cAppL10n.stagingBanner_message),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        actions: [
          TextButton(
            onPressed: _openProductionWebsite,
            child: Text(context.cAppL10n.stagingBanner_button),
          ),
        ],
      ),
    );
  }
}
