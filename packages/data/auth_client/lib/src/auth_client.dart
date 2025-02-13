import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cauth_client/cauth_client.dart';
import 'package:supabase/supabase.dart';

/// {@template CAuthClient}
///
/// A client for interacting with the Supabase auth API.
///
/// {@endtemplate}
class CAuthClient {
  /// {@macro CAuthClient}
  const CAuthClient({required this.authClient});

  /// The API client to interact with Supabase auth.
  final GoTrueClient authClient;

  /// The currently logged in user.
  CRawAuthUser? get currentUser {
    final session = authClient.currentSession;
    return session != null ? CRawAuthUser.fromSupabaseSession(session) : null;
  }

  /// The stream for the currently logged in user.
  BobsStream<CRawCurrentUserStreamException, BobsMaybe<CRawAuthUser>>
      currentUserStream() => BobsStream.attempt(
            stream: authClient.onAuthStateChange,
            onError: CRawCurrentUserStreamException.fromError,
          ).thenConvertSuccess((authState) {
            if (authState.session != null) {
              final user = CRawAuthUser.fromSupabaseSession(authState.session!);
              return bobsPresent(user);
            }
            return bobsAbsent();
          });

  /// Sends a one-time-password to the given `email`.
  ///
  /// A new user will be created.
  BobsJob<CRawSignupException, BobsNothing> signUpWithOTP({
    required String email,
    required String username,
    String? avatarURL,
  }) =>
      BobsJob.attempt(
        run: () => authClient.signInWithOtp(
          email: email,
          shouldCreateUser: true,
          data: {
            'display_name': username,
            if (avatarURL != null) 'avatar_url': avatarURL,
          },
        ),
        onError: CRawSignupException.fromError,
      ).thenConvertSuccess((_) => bobsNothing);

  /// Sends a one-time-password to the given `email`.
  ///
  /// No user will be created.
  BobsJob<CRawLoginException, BobsNothing> logInWithOTP({
    required String email,
  }) =>
      BobsJob.attempt(
        run: () =>
            authClient.signInWithOtp(email: email, shouldCreateUser: false),
        onError: CRawLoginException.fromError,
      ).thenConvertSuccess((_) => bobsNothing);

  /// Verifies the one-time-pin that was sent to a user's `email`.
  ///
  /// Set `isSignUp` to true, if the user is signing up.
  BobsJob<CRawOTPVerificationException, BobsNothing> verifyOTP({
    required String email,
    required String pin,
  }) =>
      BobsJob.attempt(
        run: () => authClient.verifyOTP(
          email: email,
          type: OtpType.email,
          token: pin,
        ),
        onError: CRawOTPVerificationException.fromError,
      ).thenConvertSuccess((_) => bobsNothing);

  /// Signs out the current user, if there is a logged in user.
  BobsJob<CRawSignoutException, BobsNothing> signOut() => BobsJob.attempt(
        run: authClient.signOut,
        onError: CRawSignoutException.fromError,
      ).thenConvertSuccess((_) => bobsNothing);

  /// Updates the user's profile.
  BobsJob<CRawAuthUserUpdateException, BobsNothing> updateUser({
    required CRawAuthUserUpdate update,
  }) =>
      BobsJob.attempt(
        run: () => authClient.updateUser(UserAttributes(data: update.toJson())),
        onError: CRawAuthUserUpdateException.fromError,
      ).thenConvertSuccess((_) => bobsNothing);

  /// Refreshes the current user's session.
  ///
  /// This is useful for keeping custom claims up-to-date.
  BobsJob<CRawSessionRefreshException, BobsNothing> refreshSession() =>
      BobsJob.attempt(
        run: authClient.refreshSession,
        onError: CRawSessionRefreshException.fromError,
      ).thenConvertSuccess((_) => bobsNothing);
}
