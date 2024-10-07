import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:chuckle_chest/shared/dialogs/_dialogs.dart';
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

  void _onChestCreated(BuildContext context, String chestID) {
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
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CChestCreationCubit, CChestCreationState>(
            listener: (context, state) => switch (state.status) {
              CRequestCubitStatus.initial => null,
              CRequestCubitStatus.inProgress => null,
              CRequestCubitStatus.succeeded =>
                _onChestCreated(context, state.chestID),
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
          CLoadingButton<CChestCreationCubit, CChestCreationState>(
            child: Text(context.cAppL10n.getStartedPage_createChestButton),
            isLoading: (state) =>
                state.status == CRequestCubitStatus.inProgress,
            onPressed: (context, cubit) =>
                CChestCreationDialog(cubit: cubit).show(context),
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
