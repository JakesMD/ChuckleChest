import 'dart:developer';

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
  Stream<BobsMaybe<CRawAuthUser>> currentUserStream() async* {
    try {
      await for (final authState in authClient.onAuthStateChange) {
        if (authState.session != null) {
          final user = CRawAuthUser.fromSupabaseSession(authState.session!);
          log(user.toString(), name: 'CAuthClient.currentUserStream');
          yield bobsPresent(user);
        } else {
          log('No user', name: 'CAuthClient.currentUserStream');
          yield bobsAbsent();
        }
      }
    } catch (e) {
      log(e.toString(), error: e, name: 'CAuthClient.currentUserStream');
      yield bobsAbsent();
    }
  }

  /// Sends a one-time-password to the given `email`.
  ///
  /// A new user will be created.
  BobsJob<CRawSignupException, BobsNothing> signUpWithOTP({
    required String email,
    required String username,
    String? avatarURL,
  }) =>
      BobsJob.attempt(
        run: () async {
          await authClient.signInWithOtp(
            email: email,
            shouldCreateUser: true,
            data: {
              'username': username,
              if (avatarURL != null) 'avatar_url': avatarURL,
            },
          );
          return bobsNothing;
        },
        onError: CRawSignupException.fromError,
      );

  /// Sends a one-time-password to the given `email`.
  ///
  /// No user will be created.
  BobsJob<CRawLoginException, BobsNothing> logInWithOTP({
    required String email,
  }) =>
      BobsJob.attempt(
        run: () async {
          await authClient.signInWithOtp(email: email, shouldCreateUser: false);
          return bobsNothing;
        },
        onError: CRawLoginException.fromError,
      );

  /// Verifies the one-time-pin that was sent to a user's `email`.
  ///
  /// Set `isSignUp` to true, if the user is signing up.
  BobsJob<CRawOTPVerificationException, BobsNothing> verifyOTP({
    required String email,
    required String pin,
  }) =>
      BobsJob.attempt(
        run: () async {
          await authClient.verifyOTP(
            email: email,
            type: OtpType.email,
            token: pin,
          );
          return bobsNothing;
        },
        onError: CRawOTPVerificationException.fromError,
      );

  /// Signs out the current user, if there is a logged in user.
  BobsJob<CRawSignoutException, BobsNothing> signOut() => BobsJob.attempt(
        run: () async {
          await authClient.signOut();
          return bobsNothing;
        },
        onError: CRawSignoutException.fromError,
      );

  /// Updates the user's profile.
  BobsJob<CRawAuthUserUpdateException, BobsNothing> updateUser({
    required CRawAuthUserUpdate update,
  }) =>
      BobsJob.attempt(
        run: () async {
          await authClient.updateUser(UserAttributes(data: update.toJson()));
          return bobsNothing;
        },
        onError: CRawAuthUserUpdateException.fromError,
      );

  /// Refreshes the current user's session.
  ///
  /// This is useful for keeping custom claims up-to-date.
  BobsJob<CRawSessionRefreshException, BobsNothing> refreshSession() =>
      BobsJob.attempt(
        run: () async {
          await authClient.refreshSession();
          return bobsNothing;
        },
        onError: CRawSessionRefreshException.fromError,
      );
}
