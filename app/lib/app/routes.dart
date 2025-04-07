import 'package:auto_route/auto_route.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/app/bootstrap/_bootstrap.dart';
import 'package:chuckle_chest/app/guards/_guards.dart';
import 'package:chuckle_chest/pages/_pages.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'routes.gr.dart';

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
  CAppRouter({required BuildContext dependencyContext})
      : currentUserCubit = dependencyContext.read<CCurrentUserCubit>();

  /// The cubit that provides the current user.
  final CCurrentUserCubit currentUserCubit;

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    if (currentUserCubit.state.isWaiting) {
      await currentUserCubit.stream.first;
    }
    resolver.next();
  }

  /// The configuration for the app.
  RouterConfig<UrlState> configure() => config(
        includePrefixMatches: true,
        reevaluateListenable:
            ReevaluateListenable.stream(currentUserCubit.isSignedInStream),
        navigatorObservers: () => [TalkerRouteObserver(cTalker)],
      );

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/signin',
          page: CSigninRoute.page,
          guards: [CSignedOutGuard(currentUserCubit: currentUserCubit)],
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
          path: '/signin/verify-otp',
          page: CVerifyOTPRoute.page,
          guards: [CSignedOutGuard(currentUserCubit: currentUserCubit)],
        ),
        AutoRoute(
          path: '/logs',
          page: CLogsRoute.page,
        ),
        AutoRoute(
          path: '/shared-gem',
          page: CSharedGemRoute.page,
        ),
        AutoRoute(
          path: '/demo',
          page: CDemoRoute.page,
        ),
        AutoRoute(
          path: '/',
          page: CBaseRoute.page,
          initial: true,
          guards: [CSignedInGuard(currentUserCubit: currentUserCubit)],
          children: [
            AutoRoute(
              path: 'get-started',
              page: CGetStartedRoute.page,
              guards: [CNoChestsGuard(currentUserCubit: currentUserCubit)],
            ),
            AutoRoute(
              path: 'create-chest',
              page: CCreateChestRoute.page,
              fullscreenDialog: true,
            ),
            AutoRoute(
              path: 'chest',
              page: CChestRoute.page,
              initial: true,
              guards: [CChestsGuard(currentUserCubit: currentUserCubit)],
              children: [
                AutoRoute(
                  path: '',
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
                      guards: [CCollaboratorGuard()],
                    ),
                    AutoRoute(
                      path: 'settings',
                      page: CSettingsRoute.page,
                    ),
                  ],
                ),
                AutoRoute(
                  path: 'create-gem',
                  page: CCreateGemRoute.page,
                  guards: [CCollaboratorGuard()],
                ),
                AutoRoute(
                  path: 'edit-gem',
                  page: CEditGemRoute.page,
                  guards: [CCollaboratorGuard()],
                ),
                AutoRoute(
                  path: 'gems/:gemID',
                  page: CGemRoute.page,
                  children: [
                    AutoRoute(
                      path: 'edit',
                      page: CEditGemRoute.page,
                      guards: [CCollaboratorGuard()],
                    ),
                  ],
                ),
                AutoRoute(
                  path: 'collections/year/:year',
                  page: CYearCollectionRoute.page,
                ),
                AutoRoute(
                  path: 'collections/recently-added',
                  page: CRecentsCollectionRoute.page,
                ),
                AutoRoute(
                  path: 'collections/randomly-selected',
                  page: CRandomCollectionRoute.page,
                ),
                AutoRoute(
                  path: 'people/edit-person',
                  page: CEditPersonRoute.page,
                  guards: [CCollaboratorGuard()],
                ),
                AutoRoute(
                  path: 'people/edit-person/edit-avatar',
                  page: CEditAvatarRoute.page,
                  guards: [CCollaboratorGuard()],
                ),
                AutoRoute(
                  path: 'settings/invitations',
                  page: CInvitationsRoute.page,
                ),
                AutoRoute(
                  path: 'settings/manage-chest',
                  page: CManageChestRoute.page,
                  guards: [COwnerGuard()],
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
        RedirectRoute(
          path: '*',
          redirectTo: '/',
        ),
      ];
}
