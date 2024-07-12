import 'dart:developer';

import 'package:cauth_client/cauth_client.dart';
import 'package:ccore/ccore.dart';
import 'package:cpub/supabase.dart';

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
  Stream<CMaybe<CRawAuthUser>> currentUserStream() async* {
    try {
      await for (final authState in authClient.onAuthStateChange) {
        if (authState.session != null) {
          yield cPresent(CRawAuthUser.fromSupabaseSession(authState.session!));
        } else {
          yield cAbsent();
        }
      }
    } catch (e) {
      log(e.toString(), error: e, name: 'CAuthClient.currentUserStream');
      yield cAbsent();
    }
  }

  /// Sends a one-time-password to the given `email`.
  ///
  /// A new user will be created.
  CJob<CRawSignupException, CNothing> signUpWithOTP({
    required String email,
    required String username,
    String? avatarURL,
  }) =>
      CJob.attempt(
        run: () async {
          await authClient.signInWithOtp(
            email: email,
            shouldCreateUser: true,
            data: {
              'username': username,
              if (avatarURL != null) 'avatar_url': avatarURL,
            },
          );
          return cNothing;
        },
        onError: CRawSignupException.fromError,
      );

  /// Sends a one-time-password to the given `email`.
  ///
  /// No user will be created.
  CJob<CRawLoginException, CNothing> logInWithOTP({
    required String email,
  }) =>
      CJob.attempt(
        run: () async {
          await authClient.signInWithOtp(email: email, shouldCreateUser: false);
          return cNothing;
        },
        onError: CRawLoginException.fromError,
      );

  /// Verifies the one-time-pin that was sent to a user's `email`.
  ///
  /// Set `isSignUp` to true, if the user is signing up.
  CJob<CRawOTPVerificationException, CNothing> verifyOTP({
    required String email,
    required String pin,
  }) =>
      CJob.attempt(
        run: () async {
          await authClient.verifyOTP(
            email: email,
            type: OtpType.email,
            token: pin,
          );
          return cNothing;
        },
        onError: CRawOTPVerificationException.fromError,
      );

  /// Signs out the current user, if there is a logged in user.
  CJob<CRawSignoutException, CNothing> signOut() => CJob.attempt(
        run: () async {
          await authClient.signOut();
          return cNothing;
        },
        onError: CRawSignoutException.fromError,
      );

  /// Updates the user's profile.
  CJob<CRawAuthUserUpdateException, CNothing> updateUser({
    required CRawAuthUserUpdate update,
  }) =>
      CJob.attempt(
        run: () async {
          await authClient.updateUser(UserAttributes(data: update.toJson()));
          return cNothing;
        },
        onError: CRawAuthUserUpdateException.fromError,
      );

  /// Refreshes the current user's session.
  ///
  /// This is useful for keeping custom claims up-to-date.
  CJob<CRawSessionRefreshException, CNothing> refreshSession() => CJob.attempt(
        run: () async {
          await authClient.refreshSession();
          return cNothing;
        },
        onError: CRawSessionRefreshException.fromError,
      );
}
