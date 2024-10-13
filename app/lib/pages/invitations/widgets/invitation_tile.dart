import 'package:cchest_repository/cchest_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CInvitationTile}
///
/// The tile on the invitations page that represents an invitation that the user
/// can accept.
///
/// {@endtemplate}
class CInvitationTile extends StatelessWidget {
  /// {@macro CInvitationTile}
  const CInvitationTile({required this.invitation, super.key});

  /// The invitation this represents.
  final CUserInvitation invitation;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(invitation.chestName),
      subtitle: Text(invitation.assignedRole.localize(context)),
      trailing: BlocBuilder<CInvitationAcceptCubit, CInvitationAcceptState>(
        builder: (context, state) => ElevatedButton(
          onPressed: state.status != CRequestCubitStatus.inProgress
              ? () => context
                  .read<CInvitationAcceptCubit>()
                  .acceptInvitation(chestID: invitation.chestID)
              : null,
          child: state.status != CRequestCubitStatus.inProgress
              ? Text(context.cAppL10n.invitationsPage_acceptButton)
              : const CCradleLoadingIndicator(ballSize: 8),
        ),
      ),
    );
  }
}
