import 'package:auto_route/auto_route.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cchest_repository/cchest_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/pages/manage_chest/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CInvitedTab}
///
/// Ths tab on the manage chest page displays the list of users that have been
/// invited to the chest and allows the user to remove them from the
/// invitation list.
///
/// {@endtemplate}
@RoutePage()
class CInvitedTab extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CInvitedTab}
  const CInvitedTab({super.key});

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
    return BlocBuilder<CChestInvitationsFetchCubit,
        CChestInvitationsFetchState>(
      builder: (context, state) => switch (state.status) {
        CRequestCubitStatus.initial =>
          const Center(child: CCradleLoadingIndicator()),
        CRequestCubitStatus.inProgress =>
          const Center(child: CCradleLoadingIndicator()),
        CRequestCubitStatus.failed =>
          const Center(child: Icon(Icons.error_rounded)),
        CRequestCubitStatus.succeeded => ListView.builder(
            itemCount: state.invitations.length,
            itemBuilder: (context, index) => ListTile(
              minVerticalPadding: 16,
              title: Text(state.invitations[index].email),
              subtitle: Text(
                state.invitations[index].assignedRole.cLocalize(context),
              ),
            ),
          ),
      },
    );
  }
}
