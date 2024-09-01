import 'dart:developer';

import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:cpub/auto_route.dart';

/// {@template CChestsGuard}
///
/// A guard that checks that the user is a member of a chest.
///
/// If the user is a member of a chest, the navigation will continue.
///
/// {@endtemplate}
class CChestsGuard implements AutoRouteGuard {
  /// {@macro CChestsGuard}
  const CChestsGuard({required this.authRepository});

  /// The authentication repository.
  final CAuthRepository authRepository;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (authRepository.currentUser!.chests.isEmpty) {
      log(
        '''Navigation from ${router.current.name} to ${resolver.routeName} denied. Redirecting to CGetStartedRoute...''',
        name: 'CChestsGuard',
      );
      resolver.redirect(const CGetStartedRoute(), replace: true);
    } else {
      resolver.next();
    }
  }
}
