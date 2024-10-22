import 'package:auto_route/auto_route.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/app/guards/_guards.dart';
import 'package:chuckle_chest/pages/_pages.dart';
import 'package:cperson_repository/cperson_repository.dart';
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
          path: '/shared-gem',
          page: CSharedGemRoute.page,
        ),
        AutoRoute(
          path: '/',
          page: CBaseRoute.page,
          initial: true,
          guards: [CSignedInGuard(authRepository: authRepository)],
          children: [
            AutoRoute(
              path: 'get-started',
              page: CGetStartedRoute.page,
              guards: [CNoChestsGuard(authRepository: authRepository)],
            ),
            AutoRoute(
              path: 'chest/:chest-id',
              page: CChestRoute.page,
              initial: true,
              guards: [CChestsGuard(authRepository: authRepository)],
              children: [
                AutoRoute(
                  path: 'home',
                  page: CHomeRoute.page,
                  initial: true,
                  children: [
                    AutoRoute(
                      path: 'collections',
                      page: CCollectionsRoute.page,
                      initial: true,
                    ),
                    AutoRoute(
                      path: 'people',
                      page: CPeopleRoute.page,
                      guards: [
                        CCollaboratorGuard(authRepository: authRepository),
                      ],
                    ),
                    AutoRoute(path: 'settings', page: CSettingsRoute.page),
                  ],
                ),
                AutoRoute(
                  path: 'create-gem',
                  page: CCreateGemRoute.page,
                  guards: [CCollaboratorGuard(authRepository: authRepository)],
                ),
                AutoRoute(
                  path: 'edit-gem',
                  page: CEditGemRoute.page,
                  guards: [CCollaboratorGuard(authRepository: authRepository)],
                ),
                AutoRoute(
                  path: 'gems/:gemID',
                  page: CGemRoute.page,
                  children: [
                    AutoRoute(
                      path: 'edit',
                      page: CEditGemRoute.page,
                      guards: [
                        CCollaboratorGuard(authRepository: authRepository),
                      ],
                    ),
                  ],
                ),
                AutoRoute(
                  path: 'year/:year',
                  page: CYearCollectionRoute.page,
                ),
                AutoRoute(
                  path: 'recently-added',
                  page: CRecentsCollectionRoute.page,
                ),
                AutoRoute(
                  path: 'randomly-selected',
                  page: CRandomCollectionRoute.page,
                ),
                AutoRoute(
                  path: 'edit-person',
                  page: CEditPersonRoute.page,
                  guards: [CCollaboratorGuard(authRepository: authRepository)],
                ),
                AutoRoute(
                  path: 'edit-avatar',
                  page: CEditAvatarRoute.page,
                  guards: [CCollaboratorGuard(authRepository: authRepository)],
                ),
                AutoRoute(
                  path: 'invitations',
                  page: CInvitationsRoute.page,
                ),
                AutoRoute(
                  path: 'manage-chest',
                  page: CManageChestRoute.page,
                  guards: [CAppRouter(authRepository: authRepository)],
                  children: [
                    AutoRoute(
                      path: 'members',
                      page: CMembersRoute.page,
                      initial: true,
                    ),
                    AutoRoute(
                      path: 'invited',
                      page: CInvitedRoute.page,
                    ),
                  ],
                ),
              ],
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
