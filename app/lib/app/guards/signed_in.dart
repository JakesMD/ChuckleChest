import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:cpub/auto_route.dart';

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
      resolver.redirect(const CSigninRoute(), replace: true);
    } else {
      resolver.next();
    }
  }
}
