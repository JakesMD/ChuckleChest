import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/manage_chest/logic/_logic.dart';
import 'package:chuckle_chest/pages/manage_chest/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'tabs/_tabs.dart';

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
        BlocProvider(
          create: (_) =>
              CInvitationCreationCubit(chestRepository: context.read()),
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
    return AutoTabsRouter.tabBar(
      routes: const [CMembersRoute(), CInvitedRoute()],
      builder: (context, child, controller) => Scaffold(
        appBar: CAppBar(
          context: context,
          title: Text(context.cAppL10n.manageChestPage_title),
        ),
        body: Column(
          children: [
            const CChangesPropagationBanner(),
            const CChestNameTile(),
            TabBar(
              controller: controller,
              tabs: [
                Tab(text: context.cAppL10n.manageChestPage_tab_members),
                Tab(text: context.cAppL10n.manageChestPage_tab_invited),
              ],
            ),
            Expanded(child: child),
          ],
        ),
        floatingActionButton: const CManageChestPageFAB(),
      ),
    );
  }
}
