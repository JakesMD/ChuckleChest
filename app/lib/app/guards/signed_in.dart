import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/guards/_guards.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/shared/_shared.dart';

/// {@template CSignedInGuard}
///
/// A guard that checks if the user is signed in.
///
/// If the user is signed in, the navigation will continue.
///
/// {@endtemplate}
class CSignedInGuard implements AutoRouteGuard {
  /// {@macro CSignedInGuard}
  const CSignedInGuard({required this.currentUserCubit});

  /// The cubit that provides the current user.
  final CCurrentUserCubit currentUserCubit;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (currentUserCubit.state.isSignedOut) {
      CGuardLog('CSignedInGuard', resolver).log();
      resolver
        ..next()
        ..redirect(const CSigninRoute(), replace: true);
    } else {
      resolver.next();
    }
  }
}
