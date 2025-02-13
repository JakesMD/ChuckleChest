import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:flutter/material.dart';

/// {@template CInvitationsTile}
///
/// The tile on the settings page that navigates to the invitations page.
///
/// {@endtemplate}
class CInvitationsTile extends StatelessWidget {
  /// {@macro CInvitationsTile}
  const CInvitationsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 16,
      leading: const Icon(Icons.inbox_rounded),
      title: Text(context.cAppL10n.settingsPage_invitationsTile_title),
      onTap: () => context.router.push(const CInvitationsRoute()),
    );
  }
}
