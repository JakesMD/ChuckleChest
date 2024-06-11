import 'dart:ui';

import 'package:ccore/ccore.dart';
import 'package:cgem_client/cgem_client.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:cplatform_client/cplatform_client.dart';
import 'package:cpub/dartz.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/mocktail.dart';
import 'package:cpub_dev/test_beautifier.dart';

class MockCGemClient extends Mock implements CGemClient {}

class MockCPlatformClient extends Mock implements CPlatformClient {}

void main() {
  group('CGemRepository tests', () {
    final gemClient = MockCGemClient();
    final platformClient = MockCPlatformClient();
    final repo = CGemRepository(
      gemClient: gemClient,
      platformClient: platformClient,
    );

    final fakeNarration = CNarration(id: BigInt.one, text: 'asdfjasflk');

    final fakeQuote = CQuote(
      id: BigInt.two,
      text: 'asdfjasflk',
      nickname: 'asdfjakl',
      age: 2,
      avatarUrl: 'asdfasd',
    );

    final fakeGem = CGem(
      id: 'adsad',
      number: 24,
      occurredAt: DateTime(2024),
      lines: [fakeNarration, fakeQuote],
    );

    // Made to match [fakeNarration].
    final fakeRawNarration = CRawLine(
      id: fakeNarration.id,
      text: fakeNarration.text,
      connection: null,
    );

    // Made to match [fakeQuote].
    final fakeRawQuote = CRawLine(
      id: fakeQuote.id,
      text: fakeQuote.text,
      connection: CRawConnection(
        nickname: fakeQuote.nickname,
        dateOfBirth: DateTime(2022),
        avatarURLs: [
          CRawAvatarURL(
            age: 2,
            url: fakeQuote.avatarUrl!,
          ),
        ],
      ),
    );

    // Made to match [fakeGem].
    final fakeRawGem = CRawGem(
      id: fakeGem.id,
      number: fakeGem.number,
      occurredAt: fakeGem.occurredAt,
      lines: [fakeRawNarration, fakeRawQuote],
    );

    setUpAll(() {
      registerFallbackValue(Rect.zero);
    });

    group('fetchGem', () {
      CJob<CRawGemFetchException, CRawGem> mockFetchGem() => gemClient.fetchGem(
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
          when(mockFetchGem).thenReturn(cFakeSuccessJob(fakeRawGem));

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
      CJob<CShareException, Unit> mockShare() => platformClient.share(
            text: any(named: 'text'),
            subject: any(named: 'subject'),
            sharePositionOrigin: any(named: 'sharePositionOrigin'),
          );

      CJob<CClipboardCopyException, Unit> mockCopyToClipboard() =>
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
          Then: 'returns success with [unit]',
        ),
        procedure(() async {
          when(() => platformClient.deviceType).thenReturn(CDeviceType.mobile);
          when(mockShare).thenReturn(cFakeSuccessJob(unit));

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
          Then: 'returns success with [unit]',
        ),
        procedure(() async {
          when(() => platformClient.deviceType).thenReturn(CDeviceType.desktop);
          when(mockCopyToClipboard).thenReturn(cFakeSuccessJob(unit));

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
