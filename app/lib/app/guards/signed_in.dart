import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/app/router.dart';

/// {@template CSignedInGuard}
///
/// A guard that checks if the user is signed in.
///
/// If the user is signed in, the navigation will continue.
///
/// {@endtemplate}
class CSignedInGuard implements AutoRouteGuard {
  /// {@macro CSignedInGuard}
  const CSignedInGuard({required this.authRepository});

  /// The authentication repository.
  final CAuthRepository authRepository;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (authRepository.currentUser == null) {
      log(
        '''Navigation from ${router.current.name} to ${resolver.routeName} denied. Redirecting to CSigninRoute...''',
        name: 'CSignedInGuard',
      );
      resolver.redirect(const CSigninRoute(), replace: true);
    } else {
      resolver.next();
    }
  }
}
