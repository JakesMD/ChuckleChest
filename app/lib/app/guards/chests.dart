import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/guards/_guards.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/shared/_shared.dart';

/// {@template CChestsGuard}
///
/// A guard that checks that the user is a member of a chest.
///
/// If the user is a member of a chest, the navigation will continue.
///
/// {@endtemplate}
class CChestsGuard implements AutoRouteGuard {
  /// {@macro CChestsGuard}
  const CChestsGuard({required this.currentUserCubit});

  /// The cubit that provides the current user.
  final CCurrentUserCubit currentUserCubit;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (currentUserCubit.state.user!.chests.isEmpty) {
      CGuardLog('CChestsGuard', resolver).log();
      resolver
        ..next(false)
        ..redirectUntil(const CGetStartedRoute(), replace: true);
      return;
    }
    resolver.next();
  }
}
