import 'package:auto_route/auto_route.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/app/guards/_guards.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A guard that checks that the user is a collaborator for the chest.
///
/// If the user is a collaborator of the chest, the navigation will continue.
class COwnerGuard implements AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final userRole = router.navigatorKey.currentContext!
        .read<CCurrentChestCubit>()
        .state
        .userRole;

    if (userRole != CUserRole.owner) {
      CGuardLog('COwnerGuard', resolver).log();
      resolver.next(false);
      return;
    }
    resolver.next();
  }
}
