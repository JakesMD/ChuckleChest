import 'dart:ui';

import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:cplatform_client/cplatform_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_beautifier/test_beautifier.dart';

class MockCGemClient extends Mock implements CGemClient {}

class MockCPlatformClient extends Mock implements CPlatformClient {}

class FakeGemRecord extends Fake implements CGemsTableRecord {
  @override
  String get id => 'adsad';

  @override
  int get number => 24;

  @override
  DateTime get occurredAt => DateTime(2024);

  @override
  List<CLinesTableRecord> get lines => [FakeLineRecord()];
}

class FakeLineRecord extends Fake implements CLinesTableRecord {
  @override
  BigInt get id => BigInt.one;

  @override
  String get text => 'asdfjasflk';

  @override
  CPeopleTableRecord? get person => null;

  @override
  BigInt get personID => BigInt.one;

  @override
  String get gemID => 'adsad';

  @override
  String get chestID => 'asdf';
}

void main() {
  group('CGemRepository tests', () {
    final gemClient = MockCGemClient();
    final platformClient = MockCPlatformClient();
    final repo = CGemRepository(
      gemClient: gemClient,
      platformClient: platformClient,
    );

    final fakeLineRecord = FakeLineRecord();

    final fakeNarration = CLine(
      id: fakeLineRecord.id,
      text: fakeLineRecord.text,
      personID: fakeLineRecord.personID,
      gemID: fakeLineRecord.gemID,
      chestID: fakeLineRecord.chestID,
    );

    final fakeGem = CGem(
      id: 'adsad',
      number: 24,
      occurredAt: DateTime(2024),
      lines: [fakeNarration],
      chestID: 'asdf',
    );

    setUpAll(() {
      registerFallbackValue(Rect.zero);
    });

    group('fetchGem', () {
      BobsJob<CRawGemFetchException, CGemsTableRecord> mockFetchGem() =>
          gemClient.fetchGem(gemID: any(named: 'gemID'));

      BobsJob<CGemFetchException, CGem> fetchGemJob() =>
          repo.fetchGem(gemID: fakeGem.id);

      test(
        requirement(
          When: 'fetch gem succeeds',
          Then: 'returns success with gem',
        ),
        procedure(() async {
          when(mockFetchGem).thenReturn(bobsFakeSuccessJob(FakeGemRecord()));

          final result = await fetchGemJob().run();

          bobsExpectSuccess(result, fakeGem);
        }),
      );

      test(
        requirement(
          When: 'fetch gem not found',
          Then: 'returns failure with [not found] exception',
        ),
        procedure(() async {
          when(mockFetchGem)
              .thenReturn(bobsFakeFailureJob(CRawGemFetchException.notFound));

          final result = await fetchGemJob().run();
          bobsExpectFailure(result, CGemFetchException.notFound);
        }),
      );

      test(
        requirement(
          When: 'fetch gem fails',
          Then: 'returns failure with [unknown] exception',
        ),
        procedure(() async {
          when(mockFetchGem)
              .thenReturn(bobsFakeFailureJob(CRawGemFetchException.unknown));

          final result = await fetchGemJob().run();
          bobsExpectFailure(result, CGemFetchException.unknown);
        }),
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
          when(mockShare).thenReturn(bobsFakeSuccessJob(bobsNothing));

          final result = await shareGemJob().run();
          bobsExpectSuccess(result, CGemShareMethod.dialog);
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
          when(mockShare)
              .thenReturn(bobsFakeFailureJob(CShareException.unknown));

          final result = await shareGemJob().run();
          bobsExpectFailure(result, CGemShareException.unknown);
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
          when(mockCopyToClipboard).thenReturn(bobsFakeSuccessJob(bobsNothing));

          final result = await shareGemJob().run();
          bobsExpectSuccess(result, CGemShareMethod.clipboard);
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
              .thenReturn(bobsFakeFailureJob(CClipboardCopyException.unknown));

          final result = await shareGemJob().run();
          bobsExpectFailure(result, CGemShareException.unknown);
        }),
      );
    });
  });
}
