import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/get_started/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CGetStartedPage}
///
/// The page that is displayed when the user is not a member of any chests.
///
/// The user can accept an invitation to join a chest or create a new chest.
///
/// {@endtemplate}
@RoutePage()
class CGetStartedPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CGetStartedPage}
  const CGetStartedPage({super.key});

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
          create: (context) => CSignoutCubit(authRepository: context.read()),
        ),
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
          BlocListener<CSignoutCubit, CSignoutState>(
            listener: (context, state) => switch (state.status) {
              CRequestCubitStatus.initial => null,
              CRequestCubitStatus.inProgress => null,
              CRequestCubitStatus.succeeded =>
                context.router.replace(const CSigninRoute()),
              CRequestCubitStatus.failed =>
                const CErrorSnackBar().show(context),
            },
          ),
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

  Future<void> _onRefresh(BuildContext context) =>
      context.read<CUserInvitationsFetchCubit>().fetchUserInvitations();

  void _onCreateChestPressed(BuildContext context) =>
      context.pushRoute(CCreateChestRoute());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.cAppL10n.getStartedPage_title),
        centerTitle: true,
        actions: const [CGetStartedPageMoreMenu()],
        bottom: CAppBarLoadingIndicator(
          listeners: [
            CLoadingListener<CSignoutCubit, CSignoutState>(),
            CLoadingListener<CInvitationAcceptCubit, CInvitationAcceptState>(),
          ],
        ),
      ),
      body: RefreshIndicator(
        key: const Key('get_started_page_refresh_indicator'),
        onRefresh: () => _onRefresh(context),
        child: CResponsiveListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          children: [
            Text(
              context.cAppL10n.getStartedPage_invitationSection_title,
              style: context.cTextTheme.titleSmall,
            ),
            const SizedBox(height: 16),
            const CInvitationSection(),
            const SizedBox(height: 48),
            Row(
              spacing: 24,
              children: [
                const Expanded(child: Divider()),
                Text(context.cAppL10n.or),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 48),
            OutlinedButton.icon(
              onPressed: () => _onCreateChestPressed(context),
              label: Text(context.cAppL10n.getStartedPage_createChestButton),
              icon: const Icon(Icons.add_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
