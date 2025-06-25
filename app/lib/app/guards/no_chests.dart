import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/guards/_guards.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/shared/_shared.dart';

/// {@template CNoChestsGuard}
///
/// A guard that checks that the user is not a member of any chests.
///
/// If the user is not a member of any chests, the navigation will continue.
///
/// {@endtemplate}
class CNoChestsGuard implements AutoRouteGuard {
  /// {@macro CNoChestsGuard}
  const CNoChestsGuard({required this.currentUserCubit});

  /// The cubit that provides the current user.
  final CCurrentUserCubit currentUserCubit;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (currentUserCubit.state.user!.chests.isNotEmpty) {
      CGuardLog('CNoChestsGuard', resolver).log();
      resolver
        ..next(false)
        ..redirectUntil(const CBaseRoute(), replace: true);
      return;
    }
    resolver.next();
  }
}
