import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/manage_chest/logic/_logic.dart';
import 'package:chuckle_chest/pages/manage_chest/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CManageChestPage}
///
/// The page that allows the user to manage a chest by inviting, removing users,
/// changing their roles and changing the chest's name.
///
/// {@endtemplate}
@RoutePage()
class CManageChestPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CManageChestPage}
  const CManageChestPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CChestNameUpdateCubit(
            chestRepository: context.read(),
            chestID: context.read<CCurrentChestCubit>().state.id,
          ),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CChestNameUpdateCubit, CChestNameUpdateState>(
            listener: (context, state) => switch (state.status) {
              CRequestCubitStatus.initial => null,
              CRequestCubitStatus.inProgress => null,
              CRequestCubitStatus.succeeded =>
                context.read<CCurrentChestCubit>().updateName(state.name),
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
      appBar: AppBar(title: Text(context.cAppL10n.manageChestPage_title)),
      body: const Column(
        children: [
          CChangesPropagationBanner(),
          Expanded(
            child: CResponsiveListView(
              padding: EdgeInsets.zero,
              children: [
                CChestNameTile(),
                Divider(height: 16),
                CMembersTile(),
                CInvitedTile(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
