import 'dart:async';

import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cauth_client/cauth_client.dart';
import 'package:ccore/ccore.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase/supabase.dart';
import 'package:test_beautifier/test_beautifier.dart';

class FakeSession extends Fake implements Session {
  @override
  String get accessToken => JWT({
        'chests': {
          'chest_id': {'name': 'name', 'role': 'viewer'},
        },
      }).sign(SecretKey(''));

  @override
  String? get refreshToken => 'refreshToken';

  // This indirectly tests the CRawAuthUser.fromSupabaseUser() method.
  @override
  User get user => const User(
        id: 'id',
        email: 'email',
        appMetadata: {},
        userMetadata: {'username': 'username'},
        aud: '',
        createdAt: '',
      );
}

class FakeUser extends Fake implements User {}

class FakeUserResponse extends Fake implements UserResponse {}

class FakeAuthResponse extends Fake implements AuthResponse {}

class FakeUserAttribures extends Fake implements UserAttributes {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

void main() {
  group('CAuthClient Tests', () {
    final goTrueClient = MockGoTrueClient();
    final client = CAuthClient(authClient: goTrueClient);

    const fakeChest = CRawAuthUserChest(
      id: 'chest_id',
      name: 'name',
      userRole: CUserRole.viewer,
    );

    // Needs to match FakeSession.user;
    const fakeUser = CRawAuthUser(
      email: 'email',
      id: 'id',
      username: 'username',
      chests: [fakeChest],
    );

    setUpAll(() {
      registerFallbackValue(FakeUserAttribures());
      registerFallbackValue(FakeAuthResponse());
      registerFallbackValue(<String, dynamic>{});
    });

    group('currentUser', () {
      test(
        requirement(
          When: 'user is signed in',
          Then: 'returns user',
        ),
        procedure(() async {
          when(() => goTrueClient.currentSession).thenReturn(FakeSession());
          expect(client.currentUser, fakeUser);
        }),
      );
      test(
        requirement(
          When: 'user is signed out',
          Then: 'returns null',
        ),
        procedure(() async {
          when(() => goTrueClient.currentSession).thenReturn(null);
          expect(client.currentUser, null);
        }),
      );
    });

    group('currentUserStream', () {
      late StreamController<AuthState> controller;

      setUp(() {
        controller = StreamController();

        when(() => goTrueClient.onAuthStateChange)
            .thenAnswer((_) => controller.stream);
      });

      test(
        requirement(
          When: 'user signs out',
          Then: 'returns [absent]',
        ),
        procedure(() async {
          late BobsOutcome<CRawCurrentUserStreamException,
              BobsMaybe<CRawAuthUser>> result;
          client.currentUserStream().stream().listen((event) => result = event);

          controller.add(const AuthState(AuthChangeEvent.signedOut, null));
          await Future.delayed(Duration.zero);

          expectBobsSuccess(result, bobsAbsent());
        }),
      );

      test(
        requirement(
          When: 'user signs in',
          Then: 'returns user',
        ),
        procedure(() async {
          late BobsOutcome<CRawCurrentUserStreamException,
              BobsMaybe<CRawAuthUser>> result;
          client.currentUserStream().stream().listen((event) => result = event);

          controller.add(AuthState(AuthChangeEvent.signedIn, FakeSession()));
          await Future.delayed(Duration.zero);

          expectBobsSuccess(result, bobsPresent(fakeUser));
        }),
      );

      test(
        requirement(
          When: 'user is initially signed in',
          Then: 'returns user',
        ),
        procedure(() async {
          late BobsOutcome<CRawCurrentUserStreamException,
              BobsMaybe<CRawAuthUser>> result;
          client.currentUserStream().stream().listen((event) => result = event);

          controller.add(
            AuthState(AuthChangeEvent.initialSession, FakeSession()),
          );
          await Future.delayed(Duration.zero);

          expectBobsSuccess(result, bobsPresent(fakeUser));
        }),
      );

      test(
        requirement(
          When: 'current user fails',
          Then: 'returns [unkown] failure',
        ),
        procedure(() async {
          late BobsOutcome<CRawCurrentUserStreamException,
              BobsMaybe<CRawAuthUser>> result;
          client.currentUserStream().stream().listen((event) => result = event);

          controller.addError(Exception());
          await Future.delayed(Duration.zero);

          expectBobsFailure(result, CRawCurrentUserStreamException.unknown);
        }),
      );

      tearDown(() => controller.close());
    });

    group('logInWithOTP', () {
      Future<void> mockSignInWithOtp() {
        return goTrueClient.signInWithOtp(
          email: any(named: 'email'),
          shouldCreateUser: false,
        );
      }

      final logInWithOTPJob = client.logInWithOTP(email: 'a@a.a');

      test(
        requirement(
          When: 'login with OTP succeeds',
          Then: 'returns [nothing]',
        ),
        procedure(() async {
          when(mockSignInWithOtp)
              .thenAnswer((_) async => AuthResponse(user: FakeUser()));

          final result = await logInWithOTPJob.run();

          expectBobsSuccess(result, bobsNothing);
        }),
      );

      test(
        requirement(
          When: 'login with OTP fails',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(mockSignInWithOtp).thenThrow(Exception());

          final result = await logInWithOTPJob.run();

          expectBobsFailure(result, CRawLoginException.unknown);
        }),
      );

      test(
        requirement(
          When: 'login with OTP and user not found',
          Then: 'returns [user not found] exception',
        ),
        procedure(() async {
          when(mockSignInWithOtp)
              .thenThrow(const AuthException('', statusCode: '422'));

          final result = await logInWithOTPJob.run();

          expectBobsFailure(result, CRawLoginException.userNotFound);
        }),
      );

      test(
        requirement(
          When: 'login with OTP and email rate limit exceeded',
          Then: 'returns [email rate limit exceeded] exception',
        ),
        procedure(() async {
          when(mockSignInWithOtp)
              .thenThrow(const AuthException('', statusCode: '429'));

          final result = await logInWithOTPJob.run();

          expectBobsFailure(result, CRawLoginException.emailRateLimitExceeded);
        }),
      );

      test(
        requirement(
          When: 'login with OTP throws unknown auth exception',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(mockSignInWithOtp).thenThrow(const AuthException(''));

          final result = await logInWithOTPJob.run();

          expectBobsFailure(result, CRawLoginException.unknown);
        }),
      );
    });

    group('signUpWithOTP', () {
      Future<void> mockSignInWithOtp() {
        return goTrueClient.signInWithOtp(
          email: any(named: 'email'),
          shouldCreateUser: true,
          data: any(named: 'data', that: isA<Map<String, dynamic>>()),
        );
      }

      final signUpWithOTPJob = client.signUpWithOTP(
        email: 'email',
        username: 'name',
        avatarURL: 'avatar',
      );

      test(
        requirement(
          When: 'signup with OTP succeeds',
          Then: 'returns [nothing]',
        ),
        procedure(() async {
          when(mockSignInWithOtp)
              .thenAnswer((_) async => AuthResponse(user: FakeUser()));

          final result = await signUpWithOTPJob.run();

          expectBobsSuccess(result, bobsNothing);
        }),
      );

      test(
        requirement(
          When: 'signup with OTP fails',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(mockSignInWithOtp).thenThrow(Exception());

          final result = await signUpWithOTPJob.run();

          expectBobsFailure(result, CRawSignupException.unknown);
        }),
      );

      test(
        requirement(
          When: 'signup with OTP throws rate limit exceeded exception',
          Then: 'returns [rate limit exceeded] exception',
        ),
        procedure(() async {
          when(mockSignInWithOtp)
              .thenThrow(const AuthException('', statusCode: '429'));

          final result = await signUpWithOTPJob.run();

          expectBobsFailure(result, CRawSignupException.emailRateLimitExceeded);
        }),
      );

      test(
        requirement(
          When: 'signup with OTP throws unknown AUTH exception',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(mockSignInWithOtp).thenThrow(const AuthException(''));

          final result = await signUpWithOTPJob.run();

          expectBobsFailure(result, CRawSignupException.unknown);
        }),
      );
    });

    group('verifyOTP', () {
      Future<AuthResponse> mockVerifyOTP() {
        return goTrueClient.verifyOTP(
          email: any(named: 'email'),
          token: any(named: 'token'),
          type: OtpType.email,
        );
      }

      final verifyOTPJob = client.verifyOTP(email: '', pin: '');

      test(
        requirement(
          Given: 'valid token',
          When: 'verify OTP succeeds',
          Then: 'returns [nothing]',
        ),
        procedure(() async {
          when(mockVerifyOTP)
              .thenAnswer((_) async => AuthResponse(user: FakeUser()));

          final result = await verifyOTPJob.run();

          expectBobsSuccess(result, bobsNothing);
        }),
      );

      test(
        requirement(
          Given: 'invalid token',
          When: 'verify OTP',
          Then: 'returns [invalid token] exception',
        ),
        procedure(() async {
          when(mockVerifyOTP)
              .thenThrow(const AuthException('', statusCode: '403'));

          final result = await verifyOTPJob.run();

          expectBobsFailure(result, CRawOTPVerificationException.invalidToken);
        }),
      );

      test(
        requirement(
          When: 'verify OTP throws unknown auth exception',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(mockVerifyOTP).thenThrow(const AuthException(''));

          final result = await verifyOTPJob.run();

          expectBobsFailure(result, CRawOTPVerificationException.unknown);
        }),
      );

      test(
        requirement(
          When: 'verify OTP fails',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(mockVerifyOTP).thenThrow(Exception());

          final result = await verifyOTPJob.run();

          expectBobsFailure(result, CRawOTPVerificationException.unknown);
        }),
      );
    });

    group('Signout', () {
      Future<void> mockSignOut() => goTrueClient.signOut();
      final signOutJob = client.signOut();

      test(
        requirement(
          Given: 'The user is signed in',
          When: 'sign out succeeds',
          Then: 'returns [nothing]',
        ),
        procedure(() async {
          when(mockSignOut).thenAnswer((_) async {});

          final result = await signOutJob.run();

          expectBobsSuccess(result, bobsNothing);
        }),
      );

      test(
        requirement(
          Given: 'The user is signed in',
          When: 'sign out fails',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(mockSignOut).thenThrow(Exception());

          final result = await signOutJob.run();

          expectBobsFailure(result, CRawSignoutException.unknown);
        }),
      );
    });

    group('updateUser', () {
      Future<UserResponse> mockUpdateUser() {
        return goTrueClient.updateUser(any(that: isA<UserAttributes>()));
      }

      final updateUserJob = client.updateUser(
        update: const CRawAuthUserUpdate(username: 'name'),
      );

      test(
        requirement(
          When: 'update user succeeds',
          Then: 'returns [nothing]',
        ),
        procedure(() async {
          when(mockUpdateUser).thenAnswer((_) async => FakeUserResponse());

          final result = await updateUserJob.run();

          expectBobsSuccess(result, bobsNothing);
        }),
      );

      test(
        requirement(
          When: 'update user fails',
          Then: 'return [unknown] exception',
        ),
        procedure(() async {
          when(mockUpdateUser).thenThrow(Exception());

          final result = await updateUserJob.run();

          expectBobsFailure(result, CRawAuthUserUpdateException.unknown);
        }),
      );
    });

    group('refreshSession', () {
      Future<AuthResponse> mockRefreshSession() {
        return goTrueClient.refreshSession();
      }

      final refreshSessionJob = client.refreshSession();

      test(
        requirement(
          When: 'session refresh succeeds',
          Then: 'returns [nothing]',
        ),
        procedure(() async {
          when(mockRefreshSession).thenAnswer((_) async => FakeAuthResponse());

          final result = await refreshSessionJob.run();

          expectBobsSuccess(result, bobsNothing);
        }),
      );

      test(
        requirement(
          When: 'session refresh fails',
          Then: 'return [unknown] exception',
        ),
        procedure(() async {
          when(mockRefreshSession).thenThrow(Exception());

          final result = await refreshSessionJob.run();

          expectBobsFailure(result, CRawSessionRefreshException.unknown);
        }),
      );
    });
  });
}
