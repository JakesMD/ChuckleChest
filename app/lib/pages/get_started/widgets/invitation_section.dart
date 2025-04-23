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
      buildWhen: (previous, state) =>
          !((state.succeeded || previous.failed) && state.inProgress),
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
                      (invitation) => CInvitationTile(invitation: invitation),
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
