import 'package:chuckle_chest/pages/_pages.dart';
import 'package:cpub/auto_route.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

/// The router for the app.
///
/// This class is responsible for defining the routes for the app.
@AutoRouterConfig(replaceInRouteName: 'Page|Tab,Route')
class CAppRouter extends _$CAppRouter implements AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    resolver.next();
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: CHomeRoute.page,
          initial: true,
        ),
        AutoRoute(
          path: '/gems/:gemID',
          page: CGemRoute.page,
        ),
        RedirectRoute(path: '/gems', redirectTo: '/'),
      ];
}
