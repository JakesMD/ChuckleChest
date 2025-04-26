import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:flutter/material.dart';

/// {@template CInvitedTile}
///
/// The tile on the manage chest page that navigates to the invited page.
///
/// {@endtemplate}
class CInvitedTile extends StatelessWidget {
  /// {@macro CInvitedTile}
  const CInvitedTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 24,
      leading: const Icon(Icons.mail_rounded),
      title: Text(context.cAppL10n.manageChestPage_invitedTile_title),
      onTap: () => context.router.push(const CInvitedRoute()),
    );
  }
}
