import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/app/router.dart';

/// {@template CNoChestsGuard}
///
/// A guard that checks that the user is not a member of any chests.
///
/// If the user is not a member of any chests, the navigation will continue.
///
/// {@endtemplate}
class CNoChestsGuard implements AutoRouteGuard {
  /// {@macro CNoChestsGuard}
  const CNoChestsGuard({required this.authRepository});

  /// The authentication repository.
  final CAuthRepository authRepository;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (authRepository.currentUser!.chests.isNotEmpty) {
      log(
        '''Navigation from ${router.current.name} to ${resolver.routeName} denied. Redirecting to CChestRoute...''',
        name: 'CNoChestsGuard',
      );
      resolver.redirect(CChestRoute(chestID: null), replace: true);
    } else {
      resolver.next();
    }
  }
}
