import 'dart:ui';

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
    late MockCGemClient gemClient;
    late MockCPlatformClient platformClient;
    late CGemRepository repo;

    final fakeNarration = CNarration(
      id: BigInt.one,
      text: 'asdfjasflk',
    );

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

    setUp(() {
      gemClient = MockCGemClient();
      platformClient = MockCPlatformClient();
      repo = CGemRepository(
        gemClient: gemClient,
        platformClient: platformClient,
      );
    });

    group('fetchGem', () {
      Future<Either<CRawGemFetchException, CRawGem>> mockFetchGem() {
        return gemClient.fetchGem(
          gemID: any(named: 'gemID'),
          withAvatarURLs: any(named: 'withAvatarURLs'),
        );
      }

      Future<Either<CGemFetchException, CGem>> fetchGem() {
        return repo.fetchGem(gemID: fakeGem.id);
      }

      test(
        requirement(
          When: 'fetch gem succeeds',
          Then: 'returns gem',
        ),
        procedure(() async {
          when(mockFetchGem).thenAnswer((_) async => right(fakeRawGem));

          final result = await fetchGem();
          expect(result, right(fakeGem));
        }),
      );

      test(
        requirement(
          When: 'fetch gem not found',
          Then: 'returns [not found] exception',
        ),
        procedure(() async {
          when(mockFetchGem)
              .thenAnswer((_) async => left(CRawGemFetchException.notFound));

          final result = await fetchGem();
          expect(result, left(CGemFetchException.notFound));
        }),
      );

      test(
        requirement(
          When: 'fetch gem fails',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(mockFetchGem)
              .thenAnswer((_) async => left(CRawGemFetchException.unknown));

          final result = await fetchGem();
          expect(result, left(CGemFetchException.unknown));
        }),
      );
    });

    group('shareGem', () {
      Future<Either<CShareException, Unit>> mockShare() {
        return platformClient.share(
          text: any(named: 'text'),
          subject: any(named: 'subject'),
          sharePositionOrigin: any(named: 'sharePositionOrigin'),
        );
      }

      Future<Either<CClipboardCopyException, Unit>> mockCopyToClipboard() {
        return platformClient.copyToClipboard(
          text: any(named: 'text'),
        );
      }

      Future<Either<CGemShareException, CGemShareMethod>> shareGem() {
        return repo.shareGem(
          gemID: fakeGem.id,
          sharePositionOrigin: Rect.zero,
          message: (_) => 'asdfa',
          subject: 'sadf',
        );
      }

      test(
        requirement(
          Given: 'device is mobile',
          When: 'share gem succeeds',
          Then: 'returns unit',
        ),
        procedure(() async {
          when(() => platformClient.deviceType).thenReturn(CDeviceType.mobile);
          when(mockShare).thenAnswer((_) async => right(unit));

          final result = await shareGem();
          expect(result, right(CGemShareMethod.dialog));
        }),
      );

      test(
        requirement(
          Given: 'device is mobile',
          When: 'share gem fails',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(() => platformClient.deviceType).thenReturn(CDeviceType.mobile);
          when(mockShare).thenAnswer(
            (_) async => left(CShareException.unknown),
          );

          final result = await shareGem();
          expect(result, left(CGemShareException.unknown));
        }),
      );

      test(
        requirement(
          Given: 'device is desktop',
          When: 'share gem succeeds',
          Then: 'returns unit',
        ),
        procedure(() async {
          when(() => platformClient.deviceType).thenReturn(CDeviceType.desktop);
          when(mockCopyToClipboard).thenAnswer((_) async => right(unit));

          final result = await shareGem();
          expect(result, right(CGemShareMethod.clipboard));
        }),
      );

      test(
        requirement(
          Given: 'device is desktop',
          When: 'share gem fails',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(() => platformClient.deviceType).thenReturn(CDeviceType.desktop);
          when(mockCopyToClipboard).thenAnswer(
            (_) async => left(CClipboardCopyException.unknown),
          );

          final result = await shareGem();
          expect(result, left(CGemShareException.unknown));
        }),
      );
    });
  });
}
