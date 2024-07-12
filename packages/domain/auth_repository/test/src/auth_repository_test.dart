import 'dart:async';

import 'package:cauth_client/cauth_client.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/mocktail.dart';
import 'package:cpub_dev/test_beautifier.dart';

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
        (_) => Stream.fromIterable([cPresent(fakeRawUser)]),
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
      late StreamController<CMaybe<CRawAuthUser>> controller;

      setUp(() {
        controller = StreamController();
        when(authClient.currentUserStream).thenAnswer((_) => controller.stream);
      });

      test(
        requirement(
          When: 'user signs in',
          Then: 'returns user',
        ),
        procedure(() async {
          var result = cAbsent<CAuthUser>();
          repo.currentUserStream().listen((event) => result = event);

          controller.add(cPresent(fakeRawUser));
          await Future.delayed(Duration.zero);

          expect(result, cPresent(fakeUser));
        }),
      );

      test(
        requirement(
          When: 'user signs out',
          Then: 'returns user',
        ),
        procedure(() async {
          var result = cAbsent<CAuthUser>();
          repo.currentUserStream().listen((event) => result = event);

          controller.add(cAbsent());
          await Future.delayed(Duration.zero);

          expect(result, cAbsent());
        }),
      );
    });

    group('signUpWithOTP', () {
      CJob<CRawSignupException, CNothing> mockSignUpWithOTP() =>
          authClient.signUpWithOTP(
            email: any(named: 'email'),
            username: any(named: 'username'),
          );

      CJob<CSignupException, CNothing> signUpWithOTPJob() => repo.signUpWithOTP(
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
          when(mockSignUpWithOTP).thenReturn(cFakeSuccessJob(cNothing));

          final result = await signUpWithOTPJob().run();

          cExpectSuccess(result, cNothing);
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
            cFakeFailureJob(CRawSignupException.emailRateLimitExceeded),
          );

          final result = await signUpWithOTPJob().run();

          cExpectFailure(result, CSignupException.emailRateLimitExceeded);
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
            cFakeFailureJob(CRawSignupException.unknown),
          );

          final result = await signUpWithOTPJob().run();

          cExpectFailure(result, CSignupException.unknown);
        }),
      );
    });

    group('logInWithOTP', () {
      CJob<CRawLoginException, CNothing> mockLogInWithOTP() =>
          authClient.logInWithOTP(email: any(named: 'email'));

      CJob<CLoginException, CNothing> logInWithOTPJob() => repo.logInWithOTP(
            email: fakeUser.email,
          );

      test(
        requirement(
          Given: 'email',
          When: 'log in with OTP succeeds',
          Then: 'returns [nothing]',
        ),
        procedure(() async {
          when(mockLogInWithOTP).thenReturn(cFakeSuccessJob(cNothing));

          final result = await logInWithOTPJob().run();

          cExpectSuccess(result, cNothing);
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
            cFakeFailureJob(CRawLoginException.emailRateLimitExceeded),
          );

          final result = await logInWithOTPJob().run();

          cExpectFailure(result, CLoginException.emailRateLimitExceeded);
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
            cFakeFailureJob(CRawLoginException.userNotFound),
          );

          final result = await logInWithOTPJob().run();

          cExpectFailure(result, CLoginException.userNotFound);
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
            cFakeFailureJob(CRawLoginException.unknown),
          );

          final result = await logInWithOTPJob().run();

          cExpectFailure(result, CLoginException.unknown);
        }),
      );
    });

    group('verifyOTP', () {
      CJob<CRawOTPVerificationException, CNothing> mockVerifyOTP() =>
          authClient.verifyOTP(
            email: any(named: 'email'),
            pin: any(named: 'pin'),
          );

      CJob<COTPVerificationException, CNothing> verifyOTPJob() =>
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
          when(mockVerifyOTP).thenReturn(cFakeSuccessJob(cNothing));

          final result = await verifyOTPJob().run();

          cExpectSuccess(result, cNothing);
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
            cFakeFailureJob(CRawOTPVerificationException.invalidToken),
          );

          final result = await verifyOTPJob().run();

          cExpectFailure(result, COTPVerificationException.invalidToken);
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
            cFakeFailureJob(CRawOTPVerificationException.unknown),
          );

          final result = await verifyOTPJob().run();

          cExpectFailure(result, COTPVerificationException.unknown);
        }),
      );
    });

    group('signOut', () {
      CJob<CRawSignoutException, CNothing> mockSignOut() =>
          authClient.signOut();

      CJob<CSignoutException, CNothing> signOutJob() => repo.signOut();

      test(
        requirement(
          When: 'sign out succeeds',
          Then: 'returns [nothing]',
        ),
        procedure(() async {
          when(mockSignOut).thenReturn(cFakeSuccessJob(cNothing));

          final result = await signOutJob().run();

          cExpectSuccess(result, cNothing);
        }),
      );

      test(
        requirement(
          When: 'sign out fails for unknown reason',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(mockSignOut).thenReturn(
            cFakeFailureJob(CRawSignoutException.unknown),
          );

          final result = await signOutJob().run();

          cExpectFailure(result, CSignoutException.unknown);
        }),
      );
    });

    group('updateUser', () {
      CJob<CRawAuthUserUpdateException, CNothing> mockUpdateUser() =>
          authClient.updateUser(update: any(named: 'update'));

      CJob<CAuthUserUpdateException, CNothing> updateUserJob() =>
          repo.updateUser(username: fakeUser.username);

      test(
        requirement(
          Given: 'username',
          When: 'update user succeeds',
          Then: 'returns [nothing]',
        ),
        procedure(() async {
          when(mockUpdateUser).thenReturn(cFakeSuccessJob(cNothing));

          final result = await updateUserJob().run();

          cExpectSuccess(result, cNothing);
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
            cFakeFailureJob(CRawAuthUserUpdateException.unknown),
          );

          final result = await updateUserJob().run();

          cExpectFailure(result, CAuthUserUpdateException.unknown);
        }),
      );
    });

    group('refreshSession', () {
      CJob<CRawSessionRefreshException, CNothing> mockRefreshSession() =>
          authClient.refreshSession();

      CJob<CSessionRefreshException, CNothing> refreshSessionJob() =>
          repo.refreshSession();

      test(
        requirement(
          When: 'refresh session succeeds',
          Then: 'returns [nothing]',
        ),
        procedure(() async {
          when(mockRefreshSession).thenReturn(cFakeSuccessJob(cNothing));

          final result = await refreshSessionJob().run();

          cExpectSuccess(result, cNothing);
        }),
      );

      test(
        requirement(
          When: 'refresh session fails for unknown reason',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(mockRefreshSession).thenReturn(
            cFakeFailureJob(CRawSessionRefreshException.unknown),
          );

          final result = await refreshSessionJob().run();

          cExpectFailure(result, CSessionRefreshException.unknown);
        }),
      );
    });
  });
}
