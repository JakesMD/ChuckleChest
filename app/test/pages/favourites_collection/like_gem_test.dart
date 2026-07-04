import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cauth_client/cauth_client.dart';
import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mallard/mallard.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_beautifier/test_beautifier.dart';

import '../../helpers/helpers.dart';

const _chestID = 'chest-1';
const _gemID = 'gem-1';

const Key _likeButtonKey = Key('collection_view_like_button');

const _fakeRawOwnerChest = CRawAuthUserChest(
  id: _chestID,
  name: 'Test Chest',
  userRole: CUserRole.owner,
);

const _fakeRawViewerChest = CRawAuthUserChest(
  id: _chestID,
  name: 'Test Chest',
  userRole: CUserRole.viewer,
);

CRawAuthUser _fakeRawUser(CRawAuthUserChest chest) => CRawAuthUser(
  id: 'user-1',
  username: 'testuser',
  email: 'test@example.com',
  chests: [chest],
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

void _setupSignedInUser(CTestClients clients, CRawAuthUserChest chest) {
  final user = _fakeRawUser(chest);
  when(clients.authClient.currentUserStream).thenAnswer(
    (_) => BobsStream(
      stream: () => Stream.value(bobsSuccess(bobsPresent(user))),
    ),
  );
  when(() => clients.authClient.currentUser).thenReturn(user);
  when(
    clients.authClient.refreshSession,
  ).thenReturn(bobsFakeSuccessJob(bobsNothing));
}

void _setupChest(
  CTestClients clients, {
  required List<String> gemIDs,
  List<String> likedGemIDs = const [],
}) {
  when(
    () => clients.personClient.fetchChestPeople(
      chestID: any(named: 'chestID'),
    ),
  ).thenReturn(bobsFakeSuccessJob(<CRawPerson>[]));

  when(
    () => clients.gemClient.fetchGemYears(chestID: any(named: 'chestID')),
  ).thenReturn(bobsFakeSuccessJob(<int>[]));

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
    () => clients.gemClient.fetchLikedGemIDs(chestID: any(named: 'chestID')),
  ).thenReturn(Task.succeed(likedGemIDs));

  when(
    () => clients.gemClient.likeGem(
      chestID: any(named: 'chestID'),
      gemID: any(named: 'gemID'),
    ),
  ).thenReturn(Task.succeed(_gemID));

  when(
    () => clients.gemClient.unlikeGem(gemID: any(named: 'gemID')),
  ).thenReturn(Task.succeed(_gemID));
}

void main() {
  group('Like Gem Tests', () {
    late CTestClients clients;

    setUp(() {
      clients = CTestClients();
    });

    testWidgets(
      requirement(
        given: 'owner viewing an unliked gem',
        whenever: 'the like button is tapped',
        then: 'calls likeGem with the chest and gem ID',
        why: 'liking a gem must persist the like exactly once',
      ),
      (tester) async {
        _setupSignedInUser(clients, _fakeRawOwnerChest);
        _setupChest(clients, gemIDs: [_gemID]);

        await tester.pumpChuckleChestApp(
          clients: clients,
          startAt: '/chest/collections/recently-added',
        );

        await tester.tap(find.byKey(_likeButtonKey));
        await tester.pumpAndSettle();

        verify(
          () => clients.gemClient.likeGem(chestID: _chestID, gemID: _gemID),
        ).called(1);
      },
    );

    testWidgets(
      requirement(
        given: 'owner viewing an already-liked gem',
        whenever: 'the like button is tapped',
        then: 'calls unlikeGem with the gem ID',
        why: 'unliking a gem must persist the removal exactly once',
      ),
      (tester) async {
        _setupSignedInUser(clients, _fakeRawOwnerChest);
        _setupChest(clients, gemIDs: [_gemID], likedGemIDs: [_gemID]);

        await tester.pumpChuckleChestApp(
          clients: clients,
          startAt: '/chest/collections/recently-added',
        );

        await tester.tap(find.byKey(_likeButtonKey));
        await tester.pumpAndSettle();

        verify(
          () => clients.gemClient.unlikeGem(gemID: _gemID),
        ).called(1);
      },
    );

    testWidgets(
      requirement(
        given: 'a gem the user has liked',
        whenever: 'navigating to the favourites collection',
        then: 'shows that gem',
        why: 'the favourites collection must display all liked gems',
      ),
      (tester) async {
        _setupSignedInUser(clients, _fakeRawOwnerChest);
        _setupChest(clients, gemIDs: [_gemID], likedGemIDs: [_gemID]);

        await tester.pumpChuckleChestApp(
          clients: clients,
          startAt: '/chest/collections/favourites',
        );

        expect(find.byKey(_likeButtonKey), findsOneWidget);
      },
    );

    testWidgets(
      requirement(
        given: 'viewer role viewing a gem',
        whenever: 'the collection view is shown',
        then: 'shows the like button but not the share button',
        why: 'viewers can like gems but cannot share them',
      ),
      (tester) async {
        _setupSignedInUser(clients, _fakeRawViewerChest);
        _setupChest(clients, gemIDs: [_gemID]);

        await tester.pumpChuckleChestApp(
          clients: clients,
          startAt: '/chest/collections/recently-added',
        );

        expect(find.byKey(_likeButtonKey), findsOneWidget);
        expect(find.byIcon(Icons.share_rounded), findsNothing);
      },
    );
  });
}
