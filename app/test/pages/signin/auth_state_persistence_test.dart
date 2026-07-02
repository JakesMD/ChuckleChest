import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cauth_client/cauth_client.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:chuckle_chest/pages/get_started/page.dart';
import 'package:chuckle_chest/pages/signin/page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_beautifier/test_beautifier.dart';

import '../../helpers/helpers.dart';

const _fakeRawUser = CRawAuthUser(
  id: 'user-1',
  username: 'testuser',
  email: 'test@example.com',
  chests: [],
);

void _setupPersistedSession(CTestClients clients) {
  when(() => clients.authClient.currentUser).thenReturn(_fakeRawUser);
  when(clients.authClient.currentUserStream).thenAnswer(
    (_) => BobsStream(
      stream: () => Stream.value(bobsSuccess(bobsPresent(_fakeRawUser))),
    ),
  );
  when(
    clients.authClient.refreshSession,
  ).thenReturn(bobsFakeSuccessJob(bobsNothing));
}

void main() {
  group('Auth State Persistence Tests', () {
    late CTestClients clients;

    setUp(() {
      clients = CTestClients();
    });

    testWidgets(
      requirement(
        given: 'user has a persisted signed-in session',
        whenever: 'app starts',
        then: 'skips signin and shows authenticated page',
        why: 'closing the app must not log the user out',
      ),
      (tester) async {
        _setupPersistedSession(clients);
        // CGetStartedPage calls fetchUserInvitations on init.
        when(
          () => clients.chestClient.fetchUserInvitations(
            email: any(named: 'email'),
          ),
        ).thenReturn(bobsFakeSuccessJob(<CRawInvitation>[]));

        await tester.pumpChuckleChestApp(clients: clients);

        expect(find.byType(CSigninPage), findsNothing);
        expect(find.byType(CGetStartedPage), findsOneWidget);
      },
    );

    testWidgets(
      requirement(
        given: 'user has no persisted session',
        whenever: 'app starts',
        then: 'shows signin page',
        why: 'unauthenticated users must be directed to sign in',
      ),
      (tester) async {
        await tester.pumpChuckleChestApp(clients: clients);

        expect(find.byType(CSigninPage), findsOneWidget);
      },
    );
  });
}
