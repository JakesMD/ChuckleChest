import 'package:auto_route/auto_route.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/home/bloc/person_creation/cubit.dart';
import 'package:chuckle_chest/pages/home/widgets/app_bar_title.dart';
import 'package:chuckle_chest/shared/cubit/_cubit.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CHomePage}
///
/// The initial page that with a bottom navigation bar.
///
/// {@endtemplate}
@RoutePage()
class CHomePage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CHomePage}

  const CHomePage({
    @PathParam.inherit('chest-id') required this.chestID,
    super.key,
  });

  /// The ID of the chesdt to display.
  final String chestID;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CPersonCreationCubit(
        personRepository: context.read(),
        chestID: context.read<CCurrentChestCubit>().state.id,
      ),
      child: Builder(
        builder: (context) =>
            BlocListener<CPersonCreationCubit, CPersonCreationState>(
          listener: (context, state) => switch (state) {
            CPersonCreationInitial() => null,
            CPersonCreationInProgress() => null,
            CPersonCreationFailure() => null,
            CPersonCreationSuccess(personID: final personID) =>
              context.router.push(CEditPersonRoute(personID: personID))
          },
          child: this,
        ),
      ),
    );
  }

  void _onChestSelected(BuildContext context, CAuthUserChest chest) {
    context.router.replace(CChestRoute(chestID: chest.id));
  }

  void _onFABPressed(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.router.push(const CCreateGemRoute());
      case 1:
        context.read<CPersonCreationCubit>().createPerson();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userRole = context.read<CCurrentChestCubit>().state.userRole;

    return AutoTabsRouter.builder(
      routes: const [CCollectionsRoute(), CPeopleRoute(), CSettingsRoute()],
      builder: (context, children, tabsRouter) => Scaffold(
        appBar: CAppBar(
          context: context,
          title: CHomePageAppBarTitle(onChestSelected: _onChestSelected),
        ),
        body: children[tabsRouter.activeIndex],
        floatingActionButton: tabsRouter.activeIndex != 2 &&
                userRole != CUserRole.viewer
            ? FloatingActionButton(
                onPressed: () => _onFABPressed(context, tabsRouter.activeIndex),
                child: const Icon(Icons.add_rounded),
              )
            : null,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: tabsRouter.setActiveIndex,
          currentIndex: tabsRouter.activeIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.diamond_outlined),
              activeIcon: const Icon(Icons.diamond_rounded),
              label: context.cAppL10n.homePage_bottomNav_collections,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.family_restroom_outlined),
              activeIcon: const Icon(Icons.family_restroom_rounded),
              label: context.cAppL10n.homePage_bottomNav_people,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings_outlined),
              activeIcon: const Icon(Icons.settings_rounded),
              label: context.cAppL10n.homePage_bottomNav_settings,
            ),
          ],
        ),
      ),
    );
  }
}
