import 'dart:ui';

import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:cplatform_client/cplatform_client.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/mocktail.dart';
import 'package:cpub_dev/test_beautifier.dart';

class MockCDatabaseClient extends Mock implements CDatabaseClient {}

class MockCPlatformClient extends Mock implements CPlatformClient {}

class FakeGemRecord extends Fake implements CGemsTableRecord {
  @override
  String get id => 'adsad';

  @override
  int get number => 24;

  @override
  DateTime get occurredAt => DateTime(2024);

  @override
  List<CLinesTableRecord> get lines =>
      [FakeNarrationRecord(), FakeQuoteRecord()];
}

class FakeNarrationRecord extends Fake implements CLinesTableRecord {
  @override
  BigInt get id => BigInt.one;

  @override
  String get text => 'asdfjasflk';

  @override
  CPeopleTableRecord? get person => null;
}

class FakeQuoteRecord extends Fake implements CLinesTableRecord {
  @override
  BigInt get id => BigInt.two;

  @override
  String get text => 'asdsdk';

  @override
  CPeopleTableRecord? get person => FakePersonRecord();
}

class FakePersonRecord extends Fake implements CPeopleTableRecord {
  @override
  String get nickname => 'asdf';

  @override
  DateTime get dateOfBirth => DateTime(2022);

  @override
  List<CAvatarURLsTableRecord> get avatarURLs => [FakeAvatarURLRecord()];
}

class FakeAvatarURLRecord extends Fake implements CAvatarURLsTableRecord {
  @override
  String get url => 'asdf';

  @override
  int get age => 2;
}

void main() {
  group('CGemRepository tests', () {
    final databaseClient = MockCDatabaseClient();
    final platformClient = MockCPlatformClient();
    final repo = CGemRepository(
      databaseClient: databaseClient,
      platformClient: platformClient,
    );

    final fakeNarrationRecord = FakeNarrationRecord();
    final fakeQuoteRecord = FakeQuoteRecord();

    final fakeNarration = CNarration(
      id: fakeNarrationRecord.id,
      text: fakeNarrationRecord.text,
    );

    final fakeQuote = CQuote(
      id: fakeQuoteRecord.id,
      text: fakeQuoteRecord.text,
      nickname: fakeQuoteRecord.person!.nickname,
      age: fakeQuoteRecord.person!.dateOfBirth.cAge(
        fakeQuoteRecord.person!.dateOfBirth.add(const Duration(days: 366 * 2)),
      ),
      avatarUrl: fakeQuoteRecord.person!.avatarURLs
          .cFirstWhereOrNull((e) => e.age == 2)
          ?.url,
    );

    final fakeGem = CGem(
      id: 'adsad',
      number: 24,
      occurredAt: DateTime(2024),
      lines: [fakeNarration, fakeQuote],
    );

    setUpAll(() {
      registerFallbackValue(Rect.zero);
    });

    group('fetchGem', () {
      CJob<CRawGemFetchException, CGemsTableRecord> mockFetchGem() =>
          databaseClient.fetchGem(
            gemID: any(named: 'gemID'),
            withAvatarURLs: any(named: 'withAvatarURLs'),
          );

      CJob<CGemFetchException, CGem> fetchGemJob() =>
          repo.fetchGem(gemID: fakeGem.id);

      test(
        requirement(
          When: 'fetch gem succeeds',
          Then: 'returns success with gem',
        ),
        procedure(() async {
          when(mockFetchGem).thenReturn(cFakeSuccessJob(FakeGemRecord()));

          final result = await fetchGemJob().run();

          cExpectSuccess(result, fakeGem);
        }),
      );

      test(
        requirement(
          When: 'fetch gem not found',
          Then: 'returns failure with [not found] exception',
        ),
        procedure(() async {
          when(mockFetchGem)
              .thenReturn(cFakeFailureJob(CRawGemFetchException.notFound));

          final result = await fetchGemJob().run();
          cExpectFailure(result, CGemFetchException.notFound);
        }),
      );

      test(
        requirement(
          When: 'fetch gem fails',
          Then: 'returns failure with [unknown] exception',
        ),
        procedure(() async {
          when(mockFetchGem)
              .thenReturn(cFakeFailureJob(CRawGemFetchException.unknown));

          final result = await fetchGemJob().run();
          cExpectFailure(result, CGemFetchException.unknown);
        }),
      );
    });

    group('shareGem', () {
      CJob<CShareException, CNothing> mockShare() => platformClient.share(
            text: any(named: 'text'),
            subject: any(named: 'subject'),
            sharePositionOrigin: any(named: 'sharePositionOrigin'),
          );

      CJob<CClipboardCopyException, CNothing> mockCopyToClipboard() =>
          platformClient.copyToClipboard(text: any(named: 'text'));

      CJob<CGemShareException, CGemShareMethod> shareGemJob() => repo.shareGem(
            gemID: fakeGem.id,
            sharePositionOrigin: Rect.zero,
            message: (_) => 'asdfa',
            subject: 'sadf',
          );

      test(
        requirement(
          Given: 'device is mobile',
          When: 'share gem succeeds',
          Then: 'returns success with [nothing]',
        ),
        procedure(() async {
          when(() => platformClient.deviceType).thenReturn(CDeviceType.mobile);
          when(mockShare).thenReturn(cFakeSuccessJob(cNothing));

          final result = await shareGemJob().run();
          cExpectSuccess(result, CGemShareMethod.dialog);
        }),
      );

      test(
        requirement(
          Given: 'device is mobile',
          When: 'share gem fails',
          Then: 'returns failure with [unknown] exception',
        ),
        procedure(() async {
          when(() => platformClient.deviceType).thenReturn(CDeviceType.mobile);
          when(mockShare).thenReturn(cFakeFailureJob(CShareException.unknown));

          final result = await shareGemJob().run();
          cExpectFailure(result, CGemShareException.unknown);
        }),
      );

      test(
        requirement(
          Given: 'device is desktop',
          When: 'share gem succeeds',
          Then: 'returns success with [nothing]',
        ),
        procedure(() async {
          when(() => platformClient.deviceType).thenReturn(CDeviceType.desktop);
          when(mockCopyToClipboard).thenReturn(cFakeSuccessJob(cNothing));

          final result = await shareGemJob().run();
          cExpectSuccess(result, CGemShareMethod.clipboard);
        }),
      );

      test(
        requirement(
          Given: 'device is desktop',
          When: 'share gem fails',
          Then: 'returns failure with [unknown] exception',
        ),
        procedure(() async {
          when(() => platformClient.deviceType).thenReturn(CDeviceType.desktop);
          when(mockCopyToClipboard)
              .thenReturn(cFakeFailureJob(CClipboardCopyException.unknown));

          final result = await shareGemJob().run();
          cExpectFailure(result, CGemShareException.unknown);
        }),
      );
    });
  });
}
