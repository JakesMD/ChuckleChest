import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/invitations/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CInvitationsPage}
///
/// The page for viewing and managing invitations.
///
/// {@endtemplate}
@RoutePage()
class CInvitationsPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CInvitationsPage}
  const CInvitationsPage({super.key});

  void _navigateToChest(BuildContext context, String chestID) {
    context.router.replaceAll(
      [const CBaseRoute(), CChestRoute(chestID: chestID)],
      updateExistingRoutes: false,
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CUserInvitationsFetchCubit(
            chestRepository: context.read(),
            authRepository: context.read(),
          )..fetchUserInvitations(),
        ),
        BlocProvider(
          create: (context) => CInvitationAcceptCubit(
            chestRepository: context.read(),
          ),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CInvitationAcceptCubit, CInvitationAcceptState>(
            listener: (context, state) => switch (state.status) {
              CRequestCubitStatus.initial => null,
              CRequestCubitStatus.inProgress => null,
              CRequestCubitStatus.succeeded =>
                _navigateToChest(context, state.chestID),
              CRequestCubitStatus.failed =>
                const CErrorSnackBar().show(context),
            },
          ),
          BlocListener<CUserInvitationsFetchCubit, CUserInvitationsFetchState>(
            listener: (context, state) => const CErrorSnackBar().show(context),
            listenWhen: (_, state) =>
                state.status == CRequestCubitStatus.failed,
          ),
        ],
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        context: context,
        title: Text(context.cAppL10n.invitationsPage_title),
      ),
      body: BlocBuilder<CUserInvitationsFetchCubit, CUserInvitationsFetchState>(
        builder: (context, state) => switch (state.status) {
          CRequestCubitStatus.initial =>
            const Center(child: CCradleLoadingIndicator()),
          CRequestCubitStatus.inProgress =>
            const Center(child: CCradleLoadingIndicator()),
          CRequestCubitStatus.failed =>
            const Center(child: Icon(Icons.error_rounded)),
          CRequestCubitStatus.succeeded => state.invitations.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: state.invitations.length,
                  itemBuilder: (context, index) => CInvitationTile(
                    invitation: state.invitations[index],
                  ),
                )
              : Center(
                  child: Text(
                    context.cAppL10n.invitationsPage_noInvitationsMessage,
                  ),
                ),
        },
      ),
    );
  }
}
