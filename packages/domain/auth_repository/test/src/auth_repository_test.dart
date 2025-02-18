import 'dart:async';

import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cauth_client/cauth_client.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_beautifier/test_beautifier.dart';

class MockBAuthClient extends Mock implements CAuthClient {}

void main() {
  group('CAuthRepository tests', () {
    final authClient = MockBAuthClient();
    final repo = CAuthRepository(authClient: authClient);

    const fakeChest = CAuthUserChest(
      id: 'asdfasdf',
      name: 'sfadsf',
      userRole: CUserRole.collaborator,
    );

    const fakeUser = CAuthUser(
      id: 'aasdfasdf',
      username: 'sdflkadsfl',
      email: 'askdlfjl',
      chests: [fakeChest],
    );

    const fakeRawChest = CRawAuthUserChest(
      id: 'asdfasdf',
      name: 'sfadsf',
      userRole: CUserRole.collaborator,
    );

    final fakeRawUser = CRawAuthUser(
      id: fakeUser.id,
      username: fakeUser.username,
      email: fakeUser.email,
      chests: [fakeRawChest],
    );

    setUpAll(() {
      registerFallbackValue(const CRawAuthUserUpdate(username: 'username'));
    });

    setUp(() {
      when(authClient.currentUserStream).thenAnswer(
        (_) => BobsStream(
          stream: () =>
              Stream.fromIterable([bobsSuccess(bobsPresent(fakeRawUser))]),
        ),
      );
    });

    group('currentUser', () {
      test(
        requirement(
          Given: 'user is signed in',
          When: 'get current user',
          Then: 'returns user',
        ),
        procedure(() async {
          when(() => authClient.currentUser).thenReturn(fakeRawUser);
          expect(repo.currentUser, fakeUser);
        }),
      );

      test(
        requirement(
          Given: 'user is signed out',
          When: 'get current user',
          Then: 'returns null',
        ),
        procedure(() async {
          when(() => authClient.currentUser).thenReturn(null);
          expect(repo.currentUser, null);
        }),
      );
    });

    group('currentUserStream', () {
      late StreamController<
          BobsOutcome<CRawCurrentUserStreamException,
              BobsMaybe<CRawAuthUser>>> controller;

      setUp(() {
        controller = StreamController();
        when(authClient.currentUserStream)
            .thenAnswer((_) => BobsStream(stream: () => controller.stream));
      });

      test(
        requirement(
          When: 'user signs in',
          Then: 'returns user',
        ),
        procedure(() async {
          var result = bobsSuccess(bobsAbsent<CAuthUser>());
          repo.currentUserStream().stream().listen((event) => result = event);

          controller.add(bobsSuccess(bobsPresent(fakeRawUser)));
          await Future.delayed(Duration.zero);

          expectBobsSuccess(result, bobsPresent(fakeUser));
        }),
      );

      test(
        requirement(
          When: 'user signs out',
          Then: 'returns user',
        ),
        procedure(() async {
          var result = bobsSuccess(bobsAbsent<CAuthUser>());
          repo.currentUserStream().stream().listen((event) => result = event);

          controller.add(bobsSuccess(bobsAbsent()));
          await Future.delayed(Duration.zero);

          expectBobsSuccess(result, bobsAbsent());
        }),
      );
      test(
        requirement(
          When: 'stream emits [unknown] exception',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          var result = bobsSuccess(bobsAbsent<CAuthUser>());
          repo.currentUserStream().stream().listen((event) => result = event);

          controller.add(bobsFailure(CRawCurrentUserStreamException.unknown));
          await Future.delayed(Duration.zero);

          expectBobsFailure(result, CCurrentUserStreamException.unknown);
        }),
      );
    });

    group('signUpWithOTP', () {
      BobsJob<CRawSignupException, BobsNothing> mockSignUpWithOTP() =>
          authClient.signUpWithOTP(
            email: any(named: 'email'),
            username: any(named: 'username'),
          );

      BobsJob<CSignupException, BobsNothing> signUpWithOTPJob() =>
          repo.signUpWithOTP(
            email: fakeUser.email,
            username: fakeUser.username,
          );

      test(
        requirement(
          Given: 'email and username',
          When: 'sign up with OTP succeeds',
          Then: 'returns [nothing]',
        ),
        procedure(() async {
          when(mockSignUpWithOTP).thenReturn(bobsFakeSuccessJob(bobsNothing));

          final result = await signUpWithOTPJob().run();

          expectBobsSuccess(result, bobsNothing);
        }),
      );

      test(
        requirement(
          Given: 'email and username',
          When: 'sign up with OTP fails for email rate limit exceeded',
          Then: 'returns [email rate limit exceeded] exception',
        ),
        procedure(() async {
          when(mockSignUpWithOTP).thenReturn(
            bobsFakeFailureJob(CRawSignupException.emailRateLimitExceeded),
          );

          final result = await signUpWithOTPJob().run();

          expectBobsFailure(result, CSignupException.emailRateLimitExceeded);
        }),
      );

      test(
        requirement(
          Given: 'email and username',
          When: 'sign up with OTP fails for unknown reason',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(mockSignUpWithOTP).thenReturn(
            bobsFakeFailureJob(CRawSignupException.unknown),
          );

          final result = await signUpWithOTPJob().run();

          expectBobsFailure(result, CSignupException.unknown);
        }),
      );
    });

    group('logInWithOTP', () {
      BobsJob<CRawLoginException, BobsNothing> mockLogInWithOTP() =>
          authClient.logInWithOTP(email: any(named: 'email'));

      BobsJob<CLoginException, BobsNothing> logInWithOTPJob() =>
          repo.logInWithOTP(
            email: fakeUser.email,
          );

      test(
        requirement(
          Given: 'email',
          When: 'log in with OTP succeeds',
          Then: 'returns [nothing]',
        ),
        procedure(() async {
          when(mockLogInWithOTP).thenReturn(bobsFakeSuccessJob(bobsNothing));

          final result = await logInWithOTPJob().run();

          expectBobsSuccess(result, bobsNothing);
        }),
      );

      test(
        requirement(
          Given: 'email',
          When: 'log in with OTP fails for email rate limit exceeded',
          Then: 'returns [email rate limit exceeded] exception',
        ),
        procedure(() async {
          when(mockLogInWithOTP).thenReturn(
            bobsFakeFailureJob(CRawLoginException.emailRateLimitExceeded),
          );

          final result = await logInWithOTPJob().run();

          expectBobsFailure(result, CLoginException.emailRateLimitExceeded);
        }),
      );

      test(
        requirement(
          Given: 'email',
          When: 'log in with OTP fails for user not found',
          Then: 'returns [user not found] exception',
        ),
        procedure(() async {
          when(mockLogInWithOTP).thenReturn(
            bobsFakeFailureJob(CRawLoginException.userNotFound),
          );

          final result = await logInWithOTPJob().run();

          expectBobsFailure(result, CLoginException.userNotFound);
        }),
      );

      test(
        requirement(
          Given: 'email',
          When: 'log in with OTP fails for unknown reason',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(mockLogInWithOTP).thenReturn(
            bobsFakeFailureJob(CRawLoginException.unknown),
          );

          final result = await logInWithOTPJob().run();

          expectBobsFailure(result, CLoginException.unknown);
        }),
      );
    });

    group('verifyOTP', () {
      BobsJob<CRawOTPVerificationException, BobsNothing> mockVerifyOTP() =>
          authClient.verifyOTP(
            email: any(named: 'email'),
            pin: any(named: 'pin'),
          );

      BobsJob<COTPVerificationException, BobsNothing> verifyOTPJob() =>
          repo.verifyOTP(
            email: fakeUser.email,
            pin: 'pin',
          );

      test(
        requirement(
          Given: 'email and token',
          When: 'verify OTP succeeds',
          Then: 'returns [nothing]',
        ),
        procedure(() async {
          when(mockVerifyOTP).thenReturn(bobsFakeSuccessJob(bobsNothing));

          final result = await verifyOTPJob().run();

          expectBobsSuccess(result, bobsNothing);
        }),
      );

      test(
        requirement(
          Given: 'email and token',
          When: 'verify OTP fails for invalid token',
          Then: 'returns [invalid token] exception',
        ),
        procedure(() async {
          when(mockVerifyOTP).thenReturn(
            bobsFakeFailureJob(CRawOTPVerificationException.invalidToken),
          );

          final result = await verifyOTPJob().run();

          expectBobsFailure(result, COTPVerificationException.invalidToken);
        }),
      );

      test(
        requirement(
          Given: 'email and token',
          When: 'verify OTP fails for unknown reason',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(mockVerifyOTP).thenReturn(
            bobsFakeFailureJob(CRawOTPVerificationException.unknown),
          );

          final result = await verifyOTPJob().run();

          expectBobsFailure(result, COTPVerificationException.unknown);
        }),
      );
    });

    group('signOut', () {
      BobsJob<CRawSignoutException, BobsNothing> mockSignOut() =>
          authClient.signOut();

      BobsJob<CSignoutException, BobsNothing> signOutJob() => repo.signOut();

      test(
        requirement(
          When: 'sign out succeeds',
          Then: 'returns [nothing]',
        ),
        procedure(() async {
          when(mockSignOut).thenReturn(bobsFakeSuccessJob(bobsNothing));

          final result = await signOutJob().run();

          expectBobsSuccess(result, bobsNothing);
        }),
      );

      test(
        requirement(
          When: 'sign out fails for unknown reason',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(mockSignOut).thenReturn(
            bobsFakeFailureJob(CRawSignoutException.unknown),
          );

          final result = await signOutJob().run();

          expectBobsFailure(result, CSignoutException.unknown);
        }),
      );
    });

    group('updateUser', () {
      BobsJob<CRawAuthUserUpdateException, BobsNothing> mockUpdateUser() =>
          authClient.updateUser(update: any(named: 'update'));

      BobsJob<CAuthUserUpdateException, BobsNothing> updateUserJob() =>
          repo.updateUser(username: fakeUser.username);

      test(
        requirement(
          Given: 'username',
          When: 'update user succeeds',
          Then: 'returns [nothing]',
        ),
        procedure(() async {
          when(mockUpdateUser).thenReturn(bobsFakeSuccessJob(bobsNothing));

          final result = await updateUserJob().run();

          expectBobsSuccess(result, bobsNothing);
        }),
      );

      test(
        requirement(
          Given: 'username',
          When: 'update user fails for unknown reason',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(mockUpdateUser).thenReturn(
            bobsFakeFailureJob(CRawAuthUserUpdateException.unknown),
          );

          final result = await updateUserJob().run();

          expectBobsFailure(result, CAuthUserUpdateException.unknown);
        }),
      );
    });

    group('refreshSession', () {
      BobsJob<CRawSessionRefreshException, BobsNothing> mockRefreshSession() =>
          authClient.refreshSession();

      BobsJob<CSessionRefreshException, BobsNothing> refreshSessionJob() =>
          repo.refreshSession();

      test(
        requirement(
          When: 'refresh session succeeds',
          Then: 'returns [nothing]',
        ),
        procedure(() async {
          when(mockRefreshSession).thenReturn(bobsFakeSuccessJob(bobsNothing));

          final result = await refreshSessionJob().run();

          expectBobsSuccess(result, bobsNothing);
        }),
      );

      test(
        requirement(
          When: 'refresh session fails for unknown reason',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(mockRefreshSession).thenReturn(
            bobsFakeFailureJob(CRawSessionRefreshException.unknown),
          );

          final result = await refreshSessionJob().run();

          expectBobsFailure(result, CSessionRefreshException.unknown);
        }),
      );
    });
  });
}
