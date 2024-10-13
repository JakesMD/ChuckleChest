import 'package:cchest_repository/cchest_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CInvitationSection}
///
/// The section on the get started page that displays the user's invitations.
///
/// The user can accept an invitation to join a chest.
///
/// {@endtemplate}
class CInvitationSection extends StatelessWidget {
  /// {@macro CInvitationSection}
  const CInvitationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CUserInvitationsFetchCubit, CUserInvitationsFetchState>(
      builder: (context, state) => switch (state.status) {
        CRequestCubitStatus.initial => const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CCradleLoadingIndicator()),
          ),
        CRequestCubitStatus.inProgress => const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CCradleLoadingIndicator()),
          ),
        CRequestCubitStatus.failed =>
          const Center(child: Icon(Icons.error_rounded)),
        CRequestCubitStatus.succeeded => state.invitations.isNotEmpty
            ? Column(
                children: state.invitations
                    .map(
                      (invitation) => _CInvitationTile(invitation: invitation),
                    )
                    .toList(),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    context.cAppL10n
                        .getStartedPage_invitationSection_noInvitations,
                  ),
                ),
              ),
      },
    );
  }
}

class _CInvitationTile extends StatelessWidget {
  const _CInvitationTile({required this.invitation});

  final CUserInvitation invitation;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(invitation.chestName),
      subtitle: Text(
        invitation.assignedRole.localize(context),
      ),
      trailing: BlocBuilder<CInvitationAcceptCubit, CInvitationAcceptState>(
        builder: (context, state) => ElevatedButton(
          onPressed: state.status != CRequestCubitStatus.inProgress
              ? () => context.read<CInvitationAcceptCubit>().acceptInvitation(
                    chestID: invitation.chestID,
                  )
              : null,
          child: state.status != CRequestCubitStatus.inProgress
              ? Text(
                  context.cAppL10n.getStartedPage_invitationTile_acceptButton,
                )
              : const CCradleLoadingIndicator(ballSize: 8),
        ),
      ),
    );
  }
}
