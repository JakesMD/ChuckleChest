import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:cpub/auto_route.dart';

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
      resolver.redirect(const CHomeRoute(), replace: true);
    } else {
      resolver.next();
    }
  }
}
