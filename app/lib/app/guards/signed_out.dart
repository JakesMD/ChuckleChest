import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/guards/_guards.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/shared/_shared.dart';

/// {@template CSignedOutGuard}
///
/// A guard that checks if the user is signed out.
///
/// If the user is signed out, the navigation will continue.
///
/// {@endtemplate}
class CSignedOutGuard implements AutoRouteGuard {
  /// {@macro CSignedOutGuard}
  const CSignedOutGuard({required this.currentUserCubit});

  /// The cubit that provides the current user.
  final CCurrentUserCubit currentUserCubit;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (currentUserCubit.state.isSignedIn) {
      CGuardLog('CSignedOutGuard', resolver).log();
      resolver
        ..next(false)
        ..redirect(const CBaseRoute(), replace: true);
    } else {
      resolver.next();
    }
  }
}
