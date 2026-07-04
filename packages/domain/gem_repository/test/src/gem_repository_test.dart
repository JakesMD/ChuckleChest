import 'dart:ui';

import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:cplatform_client/cplatform_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mallard/mallard.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_beautifier/test_beautifier.dart';

class _MockCGemClient extends Mock implements CGemClient {}

class _MockCPlatformClient extends Mock implements CPlatformClient {}

const _chestID = 'chest-1';
const _gemID = 'gem-1';
const _shareToken = 'share-token-abc';

CRawGem _fakeRawGem() => CRawGem(
  {
    'id': _gemID,
    'chest_id': _chestID,
    'number': 1,
    'occurred_at': '2024-01-15T10:00:00.000Z',
    'lines': <Map<String, dynamic>>[],
    'gem_share_tokens': null,
  },
  null,
);

void main() {
  group('CGemRepository', () {
    late _MockCGemClient gemClient;
    late _MockCPlatformClient platformClient;
    late CGemRepository repo;

    setUpAll(() {
      registerFallbackValue(Rect.zero);
      registerFallbackValue(
        CGemShareTokensTableInsert(chestID: _chestID, gemID: _gemID),
      );
      registerFallbackValue(
        CGemsTableUpsert(
          occurredAt: DateTime(2024),
          chestID: _chestID,
        ),
      );
      registerFallbackValue(
        CLinesTableInsert(text: '', gemID: _gemID, chestID: _chestID),
      );
    });

    setUp(() {
      gemClient = _MockCGemClient();
      platformClient = _MockCPlatformClient();
      repo = CGemRepository(
        gemClient: gemClient,
        platformClient: platformClient,
      );
    });

    group('fetchGemYears', () {
      BobsJob<CRawGemYearsFetchException, List<int>> mockFetchGemYears() =>
          gemClient.fetchGemYears(chestID: any(named: 'chestID'));

      BobsJob<CGemYearsFetchException, List<int>> fetchGemYearsJob() =>
          repo.fetchGemYears(chestID: _chestID);

      test(
        requirement(
          given: 'chest ID',
          whenever: 'fetchGemYears succeeds',
          then: 'returns years list',
        ),
        () async {
          when(mockFetchGemYears).thenReturn(bobsFakeSuccessJob([2023, 2024]));

          final result = await fetchGemYearsJob().run();

          expect(result.asSuccess, equals([2023, 2024]));
        },
      );

      test(
        requirement(
          given: 'chest ID',
          whenever: 'fetchGemYears fails for unknown reason',
          then: 'returns [unknown] exception',
        ),
        () async {
          when(mockFetchGemYears).thenReturn(
            bobsFakeFailureJob(CRawGemYearsFetchException.unknown),
          );

          final result = await fetchGemYearsJob().run();

          expectBobsFailure(result, CGemYearsFetchException.unknown);
        },
      );
    });

    group('fetchGemIDsForYear', () {
      BobsJob<CRawGemIDsFetchException, List<String>> mockFetch() =>
          gemClient.fetchGemIDsForYear(
            chestID: any(named: 'chestID'),
            year: any(named: 'year'),
          );

      BobsJob<CGemIDsFetchException, List<String>> fetchJob() =>
          repo.fetchGemIDsForYear(chestID: _chestID, year: 2024);

      test(
        requirement(
          given: 'chest ID and year',
          whenever: 'fetchGemIDsForYear succeeds',
          then: 'returns gem IDs list',
        ),
        () async {
          when(mockFetch).thenReturn(bobsFakeSuccessJob([_gemID]));

          final result = await fetchJob().run();

          expect(result.asSuccess, equals([_gemID]));
        },
      );

      test(
        requirement(
          given: 'chest ID and year',
          whenever: 'fetchGemIDsForYear fails for unknown reason',
          then: 'returns [unknown] exception',
        ),
        () async {
          when(mockFetch).thenReturn(
            bobsFakeFailureJob(CRawGemIDsFetchException.unknown),
          );

          final result = await fetchJob().run();

          expectBobsFailure(result, CGemIDsFetchException.unknown);
        },
      );
    });

    group('fetchRecentGemIDs', () {
      BobsJob<CRawGemIDsFetchException, List<String>> mockFetch() =>
          gemClient.fetchRecentGemIDs(
            chestID: any(named: 'chestID'),
            limit: any(named: 'limit'),
          );

      BobsJob<CGemIDsFetchException, List<String>> fetchJob() =>
          repo.fetchRecentGemIDs(chestID: _chestID);

      test(
        requirement(
          given: 'chest ID',
          whenever: 'fetchRecentGemIDs succeeds',
          then: 'returns gem IDs list',
        ),
        () async {
          when(mockFetch).thenReturn(bobsFakeSuccessJob([_gemID]));

          final result = await fetchJob().run();

          expect(result.asSuccess, equals([_gemID]));
        },
      );

      test(
        requirement(
          given: 'chest ID',
          whenever: 'fetchRecentGemIDs fails for unknown reason',
          then: 'returns [unknown] exception',
        ),
        () async {
          when(
            mockFetch,
          ).thenReturn(bobsFakeFailureJob(CRawGemIDsFetchException.unknown));

          final result = await fetchJob().run();

          expectBobsFailure(result, CGemIDsFetchException.unknown);
        },
      );
    });

    group('fetchGem', () {
      BobsJob<CRawGemFetchException, CRawGem> mockFetchGem() =>
          gemClient.fetchGem(gemID: any(named: 'gemID'));

      BobsJob<CGemFetchException, CGem> fetchGemJob() =>
          repo.fetchGem(gemID: _gemID);

      test(
        requirement(
          given: 'gem ID',
          whenever: 'fetchGem succeeds',
          then: 'returns converted CGem',
        ),
        () async {
          when(mockFetchGem).thenReturn(bobsFakeSuccessJob(_fakeRawGem()));

          final result = await fetchGemJob().run();

          expectBobsSuccess(result, CGem.fromRaw(_fakeRawGem()));
        },
      );

      test(
        requirement(
          given: 'gem ID',
          whenever: 'fetchGem fails with not found',
          then: 'returns [not found] exception',
        ),
        () async {
          when(mockFetchGem).thenReturn(
            bobsFakeFailureJob(CRawGemFetchException.notFound),
          );

          final result = await fetchGemJob().run();

          expectBobsFailure(result, CGemFetchException.notFound);
        },
      );

      test(
        requirement(
          given: 'gem ID',
          whenever: 'fetchGem fails for unknown reason',
          then: 'returns [unknown] exception',
        ),
        () async {
          when(
            mockFetchGem,
          ).thenReturn(bobsFakeFailureJob(CRawGemFetchException.unknown));

          final result = await fetchGemJob().run();

          expectBobsFailure(result, CGemFetchException.unknown);
        },
      );
    });

    group('saveGem', () {
      final fakeGem = CGem.fromRaw(_fakeRawGem());

      BobsJob<CRawGemSaveException, String> mockSaveGem() => gemClient.saveGem(
        gem: any(named: 'gem'),
        deletedLineIDs: any(named: 'deletedLineIDs'),
        lines: any(named: 'lines'),
      );

      BobsJob<CGemSaveException, String> saveGemJob() =>
          repo.saveGem(gem: fakeGem, deletedLines: []);

      test(
        requirement(
          given: 'gem',
          whenever: 'saveGem succeeds',
          then: 'returns gem ID',
        ),
        () async {
          when(mockSaveGem).thenReturn(bobsFakeSuccessJob(_gemID));

          final result = await saveGemJob().run();

          expectBobsSuccess(result, _gemID);
        },
      );

      test(
        requirement(
          given: 'gem',
          whenever: 'saveGem fails for unknown reason',
          then: 'returns [unknown] exception',
        ),
        () async {
          when(
            mockSaveGem,
          ).thenReturn(bobsFakeFailureJob(CRawGemSaveException.unknown));

          final result = await saveGemJob().run();

          expectBobsFailure(result, CGemSaveException.unknown);
        },
      );
    });

    group('deleteGem', () {
      Task<String, CRawGemDeleteException> mockDeleteGem() =>
          gemClient.deleteGem(gemID: any(named: 'gemID'));

      Task<String, CGemDeleteException> deleteGemTask() =>
          repo.deleteGem(gemID: _gemID);

      test(
        requirement(
          given: 'gem ID',
          whenever: 'deleteGem succeeds',
          then: 'returns deleted gem ID',
        ),
        () async {
          when(mockDeleteGem).thenReturn(Task.succeed(_gemID));

          final result = await deleteGemTask().run();

          expect(result.asSuccess, _gemID);
        },
      );

      test(
        requirement(
          given: 'gem ID',
          whenever: 'deleteGem fails for unknown reason',
          then: 'returns [unknown] exception',
        ),
        () async {
          when(
            mockDeleteGem,
          ).thenReturn(Task.fail(CRawGemDeleteException.unknown));

          final result = await deleteGemTask().run();

          expect(result.asFailure, CGemDeleteException.unknown);
        },
      );
    });

    group('shareGem', () {
      BobsJob<CShareException, BobsNothing> mockShare() => platformClient.share(
        text: any(named: 'text'),
        subject: any(named: 'subject'),
        sharePositionOrigin: any(named: 'sharePositionOrigin'),
      );

      BobsJob<CClipboardCopyException, BobsNothing> mockCopyToClipboard() =>
          platformClient.copyToClipboard(text: any(named: 'text'));

      BobsJob<CGemShareException, CGemShareMethod> shareGemJob() =>
          repo.shareGem(
            shareToken: _shareToken,
            sharePositionOrigin: Rect.zero,
            message: (link) => link,
            subject: 'subject',
          );

      test(
        requirement(
          given: 'mobile device',
          whenever: 'shareGem succeeds',
          then: 'shares via dialog and returns [dialog] method',
        ),
        () async {
          when(() => platformClient.deviceType).thenReturn(CDeviceType.mobile);
          when(mockShare).thenReturn(bobsFakeSuccessJob(bobsNothing));

          final result = await shareGemJob().run();

          expectBobsSuccess(result, CGemShareMethod.dialog);
        },
      );

      test(
        requirement(
          given: 'desktop device',
          whenever: 'shareGem succeeds',
          then: 'copies to clipboard and returns [clipboard] method',
        ),
        () async {
          when(() => platformClient.deviceType).thenReturn(CDeviceType.desktop);
          when(mockCopyToClipboard).thenReturn(bobsFakeSuccessJob(bobsNothing));

          final result = await shareGemJob().run();

          expectBobsSuccess(result, CGemShareMethod.clipboard);
        },
      );

      test(
        requirement(
          given: 'mobile device',
          whenever: 'shareGem fails for unknown reason',
          then: 'returns [unknown] exception',
        ),
        () async {
          when(() => platformClient.deviceType).thenReturn(CDeviceType.mobile);
          when(
            mockShare,
          ).thenReturn(bobsFakeFailureJob(CShareException.unknown));

          final result = await shareGemJob().run();

          expectBobsFailure(result, CGemShareException.unknown);
        },
      );

      test(
        requirement(
          given: 'desktop device',
          whenever: 'shareGem fails for unknown reason',
          then: 'returns [unknown] exception',
        ),
        () async {
          when(() => platformClient.deviceType).thenReturn(CDeviceType.desktop);
          when(
            mockCopyToClipboard,
          ).thenReturn(bobsFakeFailureJob(CClipboardCopyException.unknown));

          final result = await shareGemJob().run();

          expectBobsFailure(result, CGemShareException.unknown);
        },
      );
    });

    group('fetchRandomGemIDs', () {
      BobsJob<CRawRandomGemIDsFetchException, List<String>> mockFetch() =>
          gemClient.fetchRandomGemIDs(
            chestID: any(named: 'chestID'),
            limit: any(named: 'limit'),
          );

      BobsJob<CRandomGemIDsFetchException, List<String>> fetchJob() =>
          repo.fetchRandomGemIDs(chestID: _chestID);

      test(
        requirement(
          given: 'chest ID',
          whenever: 'fetchRandomGemIDs succeeds',
          then: 'returns gem IDs list',
        ),
        () async {
          when(mockFetch).thenReturn(bobsFakeSuccessJob([_gemID]));

          final result = await fetchJob().run();

          expect(result.asSuccess, equals([_gemID]));
        },
      );

      test(
        requirement(
          given: 'chest ID',
          whenever: 'fetchRandomGemIDs fails for unknown reason',
          then: 'returns [unknown] exception',
        ),
        () async {
          when(mockFetch).thenReturn(
            bobsFakeFailureJob(CRawRandomGemIDsFetchException.unknown),
          );

          final result = await fetchJob().run();

          expectBobsFailure(result, CRandomGemIDsFetchException.unknown);
        },
      );
    });

    group('fetchGemFromShareToken', () {
      BobsJob<CRawGemFetchFromShareTokenException, (CRawGem, List<CRawPerson>)>
      mockFetch() => gemClient.fetchGemFromShareToken(
        shareToken: any(named: 'shareToken'),
      );

      BobsJob<CGemFetchFromShareTokenException, CSharedGem> fetchJob() =>
          repo.fetchGemFromShareToken(shareToken: _shareToken);

      test(
        requirement(
          given: 'share token',
          whenever: 'fetchGemFromShareToken succeeds',
          then: 'returns converted CSharedGem',
        ),
        () async {
          when(mockFetch).thenReturn(
            bobsFakeSuccessJob((_fakeRawGem(), <CRawPerson>[])),
          );

          final result = await fetchJob().run();

          expectBobsSuccess(
            result,
            CSharedGem.fromRaw(_fakeRawGem(), []),
          );
        },
      );

      test(
        requirement(
          given: 'share token',
          whenever: 'fetchGemFromShareToken fails for unknown reason',
          then: 'returns [unknown] exception',
        ),
        () async {
          when(mockFetch).thenReturn(
            bobsFakeFailureJob(CRawGemFetchFromShareTokenException.unknown),
          );

          final result = await fetchJob().run();

          expectBobsFailure(result, CGemFetchFromShareTokenException.unknown);
        },
      );
    });

    group('createGemShareToken', () {
      BobsJob<CRawGemShareTokenInsertException, CRawGemShareToken>
      mockCreate() => gemClient.createGemShareToken(
        record: any(named: 'record'),
      );

      BobsJob<CGemShareTokenCreationException, String> createJob() =>
          repo.createGemShareToken(chestID: _chestID, gemID: _gemID);

      test(
        requirement(
          given: 'chest ID and gem ID',
          whenever: 'createGemShareToken succeeds',
          then: 'returns share token string',
        ),
        () async {
          when(mockCreate).thenReturn(
            bobsFakeSuccessJob(CRawGemShareToken({'token': _shareToken}, null)),
          );

          final result = await createJob().run();

          expectBobsSuccess(result, _shareToken);
        },
      );

      test(
        requirement(
          given: 'chest ID and gem ID',
          whenever: 'createGemShareToken fails for unknown reason',
          then: 'returns [unknown] exception',
        ),
        () async {
          when(mockCreate).thenReturn(
            bobsFakeFailureJob(CRawGemShareTokenInsertException.unknown),
          );

          final result = await createJob().run();

          expectBobsFailure(result, CGemShareTokenCreationException.unknown);
        },
      );
    });

    group('fetchLikedGemIDs', () {
      Task<List<String>, CRawGemIDsFetchException> mockFetch() =>
          gemClient.fetchLikedGemIDs(chestID: any(named: 'chestID'));

      Task<List<String>, CGemIDsFetchException> fetchTask() =>
          repo.fetchLikedGemIDs(chestID: _chestID);

      test(
        requirement(
          given: 'chest ID',
          whenever: 'fetchLikedGemIDs succeeds',
          then: 'returns liked gem IDs list',
        ),
        () async {
          when(mockFetch).thenReturn(Task.succeed([_gemID]));

          final result = await fetchTask().run();

          expect(result.asSuccess, equals([_gemID]));
        },
      );

      test(
        requirement(
          given: 'chest ID',
          whenever: 'fetchLikedGemIDs fails for unknown reason',
          then: 'returns [unknown] exception',
        ),
        () async {
          when(
            mockFetch,
          ).thenReturn(Task.fail(CRawGemIDsFetchException.unknown));

          final result = await fetchTask().run();

          expect(result.asFailure, CGemIDsFetchException.unknown);
        },
      );
    });

    group('likeGem', () {
      Task<String, CRawGemLikeInsertException> mockLikeGem() =>
          gemClient.likeGem(
            chestID: any(named: 'chestID'),
            gemID: any(named: 'gemID'),
          );

      Task<String, CGemLikeInsertException> likeGemTask() =>
          repo.likeGem(chestID: _chestID, gemID: _gemID);

      test(
        requirement(
          given: 'chest ID and gem ID',
          whenever: 'likeGem succeeds',
          then: 'returns liked gem ID',
        ),
        () async {
          when(mockLikeGem).thenReturn(Task.succeed(_gemID));

          final result = await likeGemTask().run();

          expect(result.asSuccess, _gemID);
        },
      );

      test(
        requirement(
          given: 'chest ID and gem ID',
          whenever: 'likeGem fails for unknown reason',
          then: 'returns [unknown] exception',
        ),
        () async {
          when(
            mockLikeGem,
          ).thenReturn(Task.fail(CRawGemLikeInsertException.unknown));

          final result = await likeGemTask().run();

          expect(result.asFailure, CGemLikeInsertException.unknown);
        },
      );
    });

    group('unlikeGem', () {
      Task<String, CRawGemLikeDeleteException> mockUnlikeGem() =>
          gemClient.unlikeGem(gemID: any(named: 'gemID'));

      Task<String, CGemLikeDeleteException> unlikeGemTask() =>
          repo.unlikeGem(gemID: _gemID);

      test(
        requirement(
          given: 'gem ID',
          whenever: 'unlikeGem succeeds',
          then: 'returns unliked gem ID',
        ),
        () async {
          when(mockUnlikeGem).thenReturn(Task.succeed(_gemID));

          final result = await unlikeGemTask().run();

          expect(result.asSuccess, _gemID);
        },
      );

      test(
        requirement(
          given: 'gem ID',
          whenever: 'unlikeGem fails for unknown reason',
          then: 'returns [unknown] exception',
        ),
        () async {
          when(
            mockUnlikeGem,
          ).thenReturn(Task.fail(CRawGemLikeDeleteException.unknown));

          final result = await unlikeGemTask().run();

          expect(result.asFailure, CGemLikeDeleteException.unknown);
        },
      );
    });
  });
}
