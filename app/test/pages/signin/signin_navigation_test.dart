import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:chuckle_chest/pages/signin/page.dart';
import 'package:chuckle_chest/pages/verify_otp/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_beautifier/test_beautifier.dart';

import '../../helpers/helpers.dart';

void main() {
  group('Signin Navigation Tests', () {
    late CTestClients clients;

    setUp(() {
      clients = CTestClients();
    });

    testWidgets(
      requirement(
        given: 'user is not signed in',
        whenever: 'app starts',
        then: 'shows signin page',
        why: 'auth flow — unauthenticated users see signin',
      ),
      (tester) async {
        await tester.pumpChuckleChestApp(clients: clients);

        expect(find.byType(CSigninPage), findsOneWidget);
      },
    );

    testWidgets(
      requirement(
        given: 'user is on login tab',
        whenever: 'enters email and taps log in',
        then: 'navigates to OTP verification page',
        why: 'auth flow — login sends OTP and navigates to verification',
      ),
      (tester) async {
        when(
          () => clients.authClient.logInWithOTP(email: any(named: 'email')),
        ).thenReturn(bobsFakeSuccessJob(bobsNothing));

        await tester.pumpChuckleChestApp(
          clients: clients,
          startAt: '/signin/login',
        );

        await tester.enterText(
          find.byType(TextFormField),
          'test@example.com',
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byType(FilledButton));
        await tester.pumpAndSettle();

        expect(find.byType(CVerifyOTPPage), findsOneWidget);
      },
    );
  });
}
