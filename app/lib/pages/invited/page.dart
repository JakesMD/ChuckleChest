import 'package:auto_route/auto_route.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cchest_repository/cchest_repository.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/invited/logic/_logic.dart';
import 'package:chuckle_chest/pages/invited/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CInvitedPage}
///
/// The page that displays the list of users that have been
/// invited to the chest and allows the user to remove them from the
/// invitation list.
///
/// {@endtemplate}
@RoutePage()
class CInvitedPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CInvitedPage}
  const CInvitedPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CChestInvitationsFetchCubit(
            chestRepository: context.read(),
            chestID: context.read<CCurrentChestCubit>().state.id,
          )..fetchChestInvitations(),
        ),
        BlocProvider(
          create: (_) =>
              CInvitationCreationCubit(chestRepository: context.read()),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CChestInvitationsFetchCubit,
              CChestInvitationsFetchState>(
            listener: (context, state) => const CErrorSnackBar().show(context),
            listenWhen: (_, state) =>
                state.status == CRequestCubitStatus.failed,
          ),
          BlocListener<CInvitationCreationCubit, CInvitationCreationState>(
            listener: (context, state) => switch (state.status) {
              CRequestCubitStatus.initial => null,
              CRequestCubitStatus.inProgress => null,
              CRequestCubitStatus.failed =>
                const CErrorSnackBar().show(context),
              CRequestCubitStatus.succeeded =>
                context.read<CChestInvitationsFetchCubit>().addInvitation(
                      invitation:
                          (state.invitation as BobsPresent<CChestInvitation>)
                              .value,
                    ),
            },
          ),
        ],
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.cAppL10n.invitedPage_title)),
      body:
          BlocBuilder<CChestInvitationsFetchCubit, CChestInvitationsFetchState>(
        builder: (context, state) => switch (state.status) {
          CRequestCubitStatus.initial =>
            const Center(child: CCradleLoadingIndicator()),
          CRequestCubitStatus.inProgress =>
            const Center(child: CCradleLoadingIndicator()),
          CRequestCubitStatus.failed =>
            const Center(child: Icon(Icons.error_rounded)),
          CRequestCubitStatus.succeeded => CResponsiveListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 32),
              items: state.invitations,
              itemBuilder: (context, invitation) =>
                  CInvitedTile(invitation: invitation),
            ),
        },
      ),
      floatingActionButton: const CInviteFAB(),
    );
  }
}
