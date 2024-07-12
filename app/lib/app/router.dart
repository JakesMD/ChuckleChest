import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/app/guards/_guards.dart';
import 'package:chuckle_chest/pages/_pages.dart';
import 'package:cpub/auto_route.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

/// {@template CAppRouter}
///
/// The router for the app.
///
/// This class is responsible for defining the routes for the app.
///
/// {@endtemplate}
@AutoRouterConfig(replaceInRouteName: 'Page|Tab,Route')
class CAppRouter extends _$CAppRouter implements AutoRouteGuard {
  /// {@macro CAppRouter}
  CAppRouter({required this.authRepository});

  /// The authentication repository.
  final CAuthRepository authRepository;

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
          guards: [CSignedInGuard(authRepository: authRepository)],
          children: [
            AutoRoute(
              path: 'get-started',
              page: CGetStartedRoute.page,
              guards: [CNoChestsGuard(authRepository: authRepository)],
            ),
            AutoRoute(
              path: 'chest',
              page: CChestRoute.page,
              initial: true,
              guards: [CChestsGuard(authRepository: authRepository)],
            ),
            AutoRoute(
              path: 'gems/:gemID',
              page: CGemRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: '/signin',
          page: CSigninRoute.page,
          guards: [CSignedOutGuard(authRepository: authRepository)],
          children: [
            AutoRoute(
              path: 'signup',
              page: CSignupRoute.page,
            ),
            AutoRoute(
              path: 'login',
              page: CLoginRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: '/verify-otp',
          page: COTPVerificationRoute.page,
          guards: [CSignedOutGuard(authRepository: authRepository)],
        ),
      ];
}
