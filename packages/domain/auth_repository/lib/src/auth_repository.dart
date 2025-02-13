import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cauth_client/cauth_client.dart';
import 'package:cauth_repository/cauth_repository.dart';

/// {@template CAuthRepository}
///
/// {@endtemplate}
class CAuthRepository {
  /// {@macro CAuthRepository}
  CAuthRepository({required this.authClient});

  /// The [CAuthClient] used to interact with the backend.
  final CAuthClient authClient;

  /// The currently logged in user.
  CAuthUser? get currentUser {
    final user = authClient.currentUser;
    return user != null ? CAuthUser.fromRawUser(user) : null;
  }

  /// The stream for the currently logged in user.
  BobsStream<CCurrentUserStreamException, BobsMaybe<CAuthUser>>
      currentUserStream() => authClient.currentUserStream().thenConvert(
            onSuccess: (user) => user.convert(CAuthUser.fromRawUser),
            onFailure: CCurrentUserStreamException.fromRaw,
          );

  /// Sends a one-time-password for signup to the given email.
  BobsJob<CSignupException, BobsNothing> signUpWithOTP({
    required String email,
    required String username,
  }) =>
      authClient
          .signUpWithOTP(email: email, username: username)
          .thenConvertFailure(CSignupException.fromRaw);

  /// Sends a one-time-password for login to the given email.
  BobsJob<CLoginException, BobsNothing> logInWithOTP({
    required String email,
  }) =>
      authClient
          .logInWithOTP(email: email)
          .thenConvertFailure(CLoginException.fromRaw);

  /// Verifies the one-time-pin that was sent to the given
  /// email.
  BobsJob<COTPVerificationException, BobsNothing> verifyOTP({
    required String email,
    required String pin,
  }) =>
      authClient
          .verifyOTP(email: email, pin: pin)
          .thenConvertFailure(COTPVerificationException.fromRaw);

  /// Signs out the current user, if there is a logged in user.
  BobsJob<CSignoutException, BobsNothing> signOut() =>
      authClient.signOut().thenConvertFailure(CSignoutException.fromRaw);

  /// Updates the current user's profile.
  BobsJob<CAuthUserUpdateException, BobsNothing> updateUser({
    required String username,
  }) =>
      authClient
          .updateUser(update: CRawAuthUserUpdate(username: username))
          .thenConvertFailure(CAuthUserUpdateException.fromRaw);

  /// Refreshes the current user's session.
  ///
  /// This is useful for keeping custom claims up-to-date.
  BobsJob<CSessionRefreshException, BobsNothing> refreshSession() => authClient
      .refreshSession()
      .thenConvertFailure(CSessionRefreshException.fromRaw);
}
