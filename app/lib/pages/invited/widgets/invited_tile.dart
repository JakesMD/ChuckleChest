import 'package:cchest_repository/cchest_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:flutter/material.dart';

/// {@template CInvitedTile}
///
/// The tile on the manage chest page that displays the list of users that have
/// been invited to the chest.
///
/// {@endtemplate}
class CInvitedTile extends StatelessWidget {
  /// {@macro CInvitedTile}
  const CInvitedTile({required this.invitation, super.key});

  /// The invitation to display.
  final CChestInvitation invitation;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 16,
      title: Text(invitation.email),
      subtitle: Text(invitation.assignedRole.cLocalize(context)),
    );
  }
}
