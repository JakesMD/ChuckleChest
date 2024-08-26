import 'package:cchest_repository/cchest_repository.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/bloc/_bloc.dart';
import 'package:chuckle_chest/shared/dialogs/_dialogs.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:cpub/auto_route.dart';
import 'package:cpub/flutter_bloc.dart';
import 'package:flutter/material.dart';

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

  void _onChestCreated(BuildContext context, String chestID) {
    context.router.replaceAll(
      [const CHomeRoute(), CChestRoute(chestID: chestID)],
      updateExistingRoutes: false,
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CChestCreationBloc(
            chestRepository: context.read<CChestRepository>(),
          ),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CChestCreationBloc, CChestCreationState>(
            listener: (context, state) => switch (state) {
              CChestCreationInitial() => null,
              CChestCreationInProgress() => null,
              CChestCreationSuccess(chestID: final chestID) =>
                _onChestCreated(context, chestID),
              CChestCreationFailure() => const CErrorSnackBar().show(context),
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
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_rounded),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text(context.cAppL10n.getStartedPage_logoutButton),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          CLoadingButton<CChestCreationBloc, CChestCreationState>(
            text: Text(context.cAppL10n.getStartedPage_createChestButton),
            isLoading: (state) => state is CChestCreationInProgress,
            onPressed: (context, bloc) =>
                CChestCreationDialog(bloc: bloc).show(context),
            builder: (context, text, onPressed) => FilledButton(
              onPressed: onPressed,
              child: text,
            ),
          ),
        ],
      ),
    );
  }
}
