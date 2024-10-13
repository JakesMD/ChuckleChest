import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/pages/settings/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:chuckle_chest/shared/widgets/error_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CSettingsPage}
///
/// A tab in the home page used to display the settings of the app.
///
/// {@endtemplate}
@RoutePage()
class CSettingsPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CSettingsPage}
  const CSettingsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CSignoutCubit(authRepository: context.read()),
        ),
        BlocProvider(
          create: (context) => CChestCreationCubit(
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
          BlocListener<CChestCreationCubit, CChestCreationState>(
            listener: (context, state) => switch (state.status) {
              CRequestCubitStatus.initial => null,
              CRequestCubitStatus.inProgress => null,
              CRequestCubitStatus.succeeded => context.router.replaceAll(
                  [const CBaseRoute(), CChestRoute(chestID: state.chestID)],
                  updateExistingRoutes: false,
                ),
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
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        ListTile(
          minVerticalPadding: 16,
          leading: const Icon(Icons.manage_accounts_rounded),
          title: const Text('Manage this chest'),
          onTap: () {},
        ),
        const Divider(height: 48),
        ListTile(
          minVerticalPadding: 16,
          leading: const Icon(Icons.inbox_rounded),
          title: const Text('Invitations'),
          onTap: () {},
        ),
        const CCreateChestTile(),
        const Divider(height: 48),
        const CSignoutTile(),
      ],
    );
  }
}
