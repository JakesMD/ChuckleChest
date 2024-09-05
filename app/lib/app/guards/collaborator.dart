import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/shared/cubit/_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CCollaboratorGuard}
///
/// A guard that checks that the user is a collaborator for the chest.
///
/// If the user is a collaborator of the chest, the navigation will continue.
///
/// {@endtemplate}
class CCollaboratorGuard implements AutoRouteGuard {
  /// {@macro CCollaboratorGuard}
  const CCollaboratorGuard({
    required this.authRepository,
  });

  /// The authentication repository.
  final CAuthRepository authRepository;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final userRole = router.navigatorKey.currentContext!
        .read<CCurrentChestCubit>()
        .state
        .userRole;

    if (userRole == CUserRole.viewer) {
      log(
        '''Navigation from ${router.current.name} to ${resolver.routeName} denied.''',
        name: 'CCollaboratorGuard',
      );
      resolver.next(false);
    } else {
      resolver.next();
    }
  }
}
