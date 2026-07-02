import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cauth_client/cauth_client.dart';
import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:chuckle_chest/pages/home/page.dart';
import 'package:chuckle_chest/pages/recents_collection/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mallard/mallard.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_beautifier/test_beautifier.dart';

import '../../helpers/helpers.dart';

const _chestID = 'chest-1';
const _gemID = 'gem-1';
const _gem2ID = 'gem-2';

const Key _menuButtonKey = Key('collection_view_gem_menu_button');
const Key _menuEditItemKey = Key('collection_view_gem_menu_edit_item');
const Key _menuDeleteItemKey = Key('collection_view_gem_menu_delete_item');
const Key _dialogKey = Key('delete_gem_dialog');
const Key _dialogDeleteButtonKey = Key('delete_gem_dialog_delete_button');

const _fakeRawChest = CRawAuthUserChest(
  id: _chestID,
  name: 'Test Chest',
  userRole: CUserRole.owner,
);

const _fakeRawUser = CRawAuthUser(
  id: 'user-1',
  username: 'testuser',
  email: 'test@example.com',
  chests: [_fakeRawChest],
);

CRawGem _makeRawGem(String id) => CRawGem(
  {
    'id': id,
    'chest_id': _chestID,
    'number': 1,
    'occurred_at': '2024-01-15T10:00:00.000Z',
    'lines': <Map<String, dynamic>>[],
    'gem_share_tokens': null,
  },
  null,
);

void _setupSignedInOwner(CTestClients clients) {
  when(clients.authClient.currentUserStream).thenAnswer(
    (_) => BobsStream(
      stream: () => Stream.value(bobsSuccess(bobsPresent(_fakeRawUser))),
    ),
  );
  when(() => clients.authClient.currentUser).thenReturn(_fakeRawUser);
  when(
    clients.authClient.refreshSession,
  ).thenReturn(bobsFakeSuccessJob(bobsNothing));
}

void _setupRecentsCollection(CTestClients clients, List<String> gemIDs) {
  when(
    () => clients.personClient.fetchChestPeople(
      chestID: any(named: 'chestID'),
    ),
  ).thenReturn(bobsFakeSuccessJob(<CRawPerson>[]));

  when(
    () => clients.gemClient.fetchRecentGemIDs(
      chestID: any(named: 'chestID'),
      limit: any(named: 'limit'),
    ),
  ).thenReturn(bobsFakeSuccessJob(gemIDs));

  for (final id in gemIDs) {
    when(
      () => clients.gemClient.fetchGem(gemID: id),
    ).thenReturn(bobsFakeSuccessJob(_makeRawGem(id)));
  }

  when(
    () => clients.gemClient.fetchGemYears(chestID: any(named: 'chestID')),
  ).thenReturn(bobsFakeSuccessJob(<int>[]));
}

void main() {
  group('Delete Gem Tests', () {
    late CTestClients clients;

    setUp(() {
      clients = CTestClients();
      _setupSignedInOwner(clients);
    });

    testWidgets(
      requirement(
        given: 'owner viewing gem in recents collection',
        whenever: 'app bar 3-dot menu is tapped',
        then: 'shows Edit and Delete options',
        why: 'owners must be able to delete gems from the collection view',
      ),
      (tester) async {
        _setupRecentsCollection(clients, [_gemID]);

        await tester.pumpChuckleChestApp(
          clients: clients,
          startAt: '/chest/collections/recently-added',
        );

        await tester.tap(find.byKey(_menuButtonKey));
        await tester.pumpAndSettle();

        expect(find.byKey(_menuButtonKey), findsOneWidget);
        expect(find.byKey(_menuEditItemKey), findsOneWidget);
        expect(find.byKey(_menuDeleteItemKey), findsOneWidget);
      },
    );

    testWidgets(
      requirement(
        given: 'owner viewing gem in recents collection',
        whenever: 'delete is selected from app bar menu',
        then: 'shows delete confirmation dialog',
        why: 'accidental deletion must be prevented with a confirmation step',
      ),
      (tester) async {
        _setupRecentsCollection(clients, [_gemID]);

        await tester.pumpChuckleChestApp(
          clients: clients,
          startAt: '/chest/collections/recently-added',
        );

        await tester.tap(find.byKey(_menuButtonKey));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(_menuDeleteItemKey));
        await tester.pumpAndSettle();

        expect(find.byKey(_dialogKey), findsOneWidget);
      },
    );

    testWidgets(
      requirement(
        given: 'delete confirmation dialog is shown',
        whenever: 'user confirms deletion',
        then: 'calls deleteGem with the correct gem ID',
        why: 'deletion must be triggered exactly once with the right gem',
      ),
      (tester) async {
        _setupRecentsCollection(clients, [_gemID]);
        when(
          () => clients.gemClient.deleteGem(gemID: any(named: 'gemID')),
        ).thenReturn(Task.succeed(_gemID));

        await tester.pumpChuckleChestApp(
          clients: clients,
          startAt: '/chest/collections/recently-added',
        );

        await tester.tap(find.byKey(_menuButtonKey));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(_menuDeleteItemKey));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(_dialogDeleteButtonKey));
        await tester.pumpAndSettle();

        verify(
          () => clients.gemClient.deleteGem(gemID: _gemID),
        ).called(1);
      },
    );

    testWidgets(
      requirement(
        given: 'collection has only one gem',
        whenever: 'user confirms deletion of that gem',
        then: 'navigates back to home page',
        why: 'no gems remain so the collection view is no longer meaningful',
      ),
      (tester) async {
        _setupRecentsCollection(clients, [_gemID]);
        when(
          () => clients.gemClient.deleteGem(gemID: any(named: 'gemID')),
        ).thenReturn(Task.succeed(_gemID));

        await tester.pumpChuckleChestApp(
          clients: clients,
          startAt: '/chest/collections/recently-added',
        );

        await tester.tap(find.byKey(_menuButtonKey));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(_menuDeleteItemKey));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(_dialogDeleteButtonKey));
        await tester.pumpAndSettle();

        expect(find.byType(CRecentsCollectionPage), findsNothing);
        expect(find.byType(CHomePage), findsOneWidget);
      },
    );

    testWidgets(
      requirement(
        given: 'collection has two gems',
        whenever: 'user deletes the first gem',
        then: 'stays on collection page showing the second gem',
        why: 'remaining gems must still be viewable after deletion',
      ),
      (tester) async {
        _setupRecentsCollection(clients, [_gemID, _gem2ID]);
        when(
          () => clients.gemClient.deleteGem(gemID: any(named: 'gemID')),
        ).thenReturn(Task.succeed(_gemID));

        await tester.pumpChuckleChestApp(
          clients: clients,
          startAt: '/chest/collections/recently-added',
        );

        await tester.tap(find.byKey(_menuButtonKey));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(_menuDeleteItemKey));
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(_dialogDeleteButtonKey));
        await tester.pumpAndSettle();

        expect(find.byType(CRecentsCollectionPage), findsOneWidget);
      },
    );
  });
}
