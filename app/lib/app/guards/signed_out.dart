import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/app/router.dart';

/// {@template CSignedOutGuard}
///
/// A guard that checks if the user is signed out.
///
/// If the user is signed out, the navigation will continue.
///
/// {@endtemplate}
class CSignedOutGuard implements AutoRouteGuard {
  /// {@macro CSignedOutGuard}
  const CSignedOutGuard({required this.authRepository});

  /// The authentication repository.
  final CAuthRepository authRepository;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (authRepository.currentUser != null) {
      log(
        '''Navigation from ${router.current.name} to ${resolver.routeName} denied. Redirecting to CSigninRoute...''',
        name: 'CHomeRoute',
      );
      resolver.redirect(const CBaseRoute(), replace: true);
    } else {
      resolver.next();
    }
  }
}
