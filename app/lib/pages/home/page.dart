import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/home/widgets/app_bar_title.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:cpub/auto_route.dart';
import 'package:flutter/material.dart';

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
    return this;
  }

  void _onChestSelected(BuildContext context, CAuthUserChest chest) {
    context.router.replace(CChestRoute(chestID: chest.id));
  }

  void _onFABPressed(BuildContext context) {
    context.router.pushNamed('create-gem');
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.builder(
      routes: const [CGemsRoute(), CSettingsRoute()],
      builder: (context, children, tabsRouter) => Scaffold(
        appBar: CAppBar(
          context: context,
          title: CHomePageAppBarTitle(onChestSelected: _onChestSelected),
        ),
        body: children[tabsRouter.activeIndex],
        floatingActionButton: tabsRouter.activeIndex == 0
            ? FloatingActionButton(
                onPressed: () => _onFABPressed(context),
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
              label: context.cAppL10n.chestPage_bottomNav_gems,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings_outlined),
              activeIcon: const Icon(Icons.settings_rounded),
              label: context.cAppL10n.chestPage_bottomNav_settings,
            ),
          ],
        ),
      ),
    );
  }
}
