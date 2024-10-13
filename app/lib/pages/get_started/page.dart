import 'package:auto_route/auto_route.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/get_started/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signed_spacing_flex/signed_spacing_flex.dart';

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
          create: (context) =>
              CChestCreationCubit(chestRepository: context.read()),
        ),
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
          BlocListener<CChestCreationCubit, CChestCreationState>(
            listener: (context, state) => switch (state.status) {
              CRequestCubitStatus.initial => null,
              CRequestCubitStatus.inProgress => null,
              CRequestCubitStatus.succeeded =>
                _navigateToChest(context, state.chestID),
              CRequestCubitStatus.failed =>
                const CErrorSnackBar().show(context),
            },
          ),
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
        title: Text(context.cAppL10n.getStartedPage_title),
        actions: const [CGetStartedPageMoreMenu()],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            context.cAppL10n.getStartedPage_invitationSection_title,
            style: context.cTextTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          const CInvitationSection(),
          const SizedBox(height: 48),
          SignedSpacingRow(
            spacing: 16,
            children: [
              const Expanded(child: Divider()),
              Text(
                context.cAppL10n.or,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 24),
          const CCreateChestButton(),
        ],
      ),
    );
  }
}
