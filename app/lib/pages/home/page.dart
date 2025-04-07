import 'package:auto_route/auto_route.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/home/logic/_logic.dart';
import 'package:chuckle_chest/pages/home/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CHomePage}
///
/// The initial page that wraps the child pages with an app bar and a bottom
/// navigation bar.
///
/// {@endtemplate}
@RoutePage()
class CHomePage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CHomePage}

  const CHomePage({super.key});

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
          listener: (context, state) => switch (state.status) {
            CRequestCubitStatus.initial => null,
            CRequestCubitStatus.inProgress => null,
            CRequestCubitStatus.failed => const CErrorSnackBar().show(context),
            CRequestCubitStatus.succeeded =>
              _onPersonCreated(context, state.person)
          },
          child: this,
        ),
      ),
    );
  }

  Future<void> _onPersonCreated(BuildContext context, CPerson person) async {
    final cubit = context.read<CChestPeopleFetchCubit>();
    final result = await context.router.push(
      CEditPersonRoute(person: person, isPersonNew: true),
    );

    if (result != null) cubit.updatePerson(person: result as CPerson);
  }

  void _onChestSelected(BuildContext context, CAuthUserChest chest) =>
      context.router.replace(CChestRoute(chestID: chest.id));

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
    final isMobile = MediaQuery.of(context).size.width < 600;

    final isViewer = context.currentChest.isUserViewer;

    return AutoTabsRouter(
      routes: [
        const CCollectionsRoute(),
        if (!isViewer) const CPeopleRoute(),
        const CSettingsRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        final childWithAppBar = Scaffold(
          appBar: AppBar(
            title: CHomePageAppBarTitle(onChestSelected: _onChestSelected),
          ),
          body: child,
        );

        return Scaffold(
          floatingActionButton: tabsRouter.activeIndex != 2 && !isViewer
              ? FloatingActionButton(
                  onPressed: () =>
                      _onFABPressed(context, tabsRouter.activeIndex),
                  child: const Icon(Icons.add_rounded),
                )
              : null,
          bottomNavigationBar: isMobile
              ? NavigationBar(
                  selectedIndex: tabsRouter.activeIndex,
                  onDestinationSelected: tabsRouter.setActiveIndex,
                  destinations: [
                    NavigationDestination(
                      icon: const Icon(Icons.diamond_outlined),
                      selectedIcon: const Icon(Icons.diamond_rounded),
                      label: context.cAppL10n.homePage_bottomNav_collections,
                    ),
                    if (!isViewer)
                      NavigationDestination(
                        icon: const Icon(Icons.family_restroom_outlined),
                        selectedIcon: const Icon(Icons.family_restroom_rounded),
                        label: context.cAppL10n.homePage_bottomNav_people,
                      ),
                    NavigationDestination(
                      icon: const Icon(Icons.settings_outlined),
                      selectedIcon: const Icon(Icons.settings_rounded),
                      label: context.cAppL10n.homePage_bottomNav_settings,
                    ),
                  ],
                )
              : null,
          body: !isMobile
              ? Row(
                  children: [
                    NavigationRail(
                      selectedIndex: tabsRouter.activeIndex,
                      onDestinationSelected: tabsRouter.setActiveIndex,
                      labelType: NavigationRailLabelType.selected,
                      destinations: [
                        NavigationRailDestination(
                          icon: const Icon(Icons.diamond_outlined),
                          selectedIcon: const Icon(Icons.diamond_rounded),
                          label: Text(
                            context.cAppL10n.homePage_bottomNav_collections,
                          ),
                        ),
                        if (!isViewer)
                          NavigationRailDestination(
                            icon: const Icon(Icons.family_restroom_outlined),
                            selectedIcon:
                                const Icon(Icons.family_restroom_rounded),
                            label: Text(
                              context.cAppL10n.homePage_bottomNav_people,
                            ),
                          ),
                        NavigationRailDestination(
                          icon: const Icon(Icons.settings_outlined),
                          selectedIcon: const Icon(Icons.settings_rounded),
                          label: Text(
                            context.cAppL10n.homePage_bottomNav_settings,
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: childWithAppBar),
                  ],
                )
              : childWithAppBar,
        );
      },
    );
  }
}
