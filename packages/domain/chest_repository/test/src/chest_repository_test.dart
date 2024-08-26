import 'dart:ui';

import 'package:cchest_repository/cchest_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/mocktail.dart';
import 'package:cpub_dev/test_beautifier.dart';

class MockCChestClient extends Mock implements CChestClient {}

class FakeChestRecord extends Fake implements CChestsTableRecord {
  @override
  String get id => 'adsad';
}

void main() {
  group('CChestRepository tests', () {
    final chestClient = MockCChestClient();
    final repo = CChestRepository(chestClient: chestClient);

    final fakeChestRecord = FakeChestRecord();

    setUpAll(() {
      registerFallbackValue(Rect.zero);
    });

    group('createChest', () {
      CJob<CRawChestCreationException, String> mockCreateChest() =>
          chestClient.createChest(chestName: any(named: 'chestName'));

      CJob<CChestCreationException, String> createChestJob() =>
          repo.createChest(chestName: fakeChestRecord.id);

      test(
        requirement(
          When: 'create chest succeeds',
          Then: 'returns success with chest ID',
        ),
        procedure(() async {
          when(mockCreateChest).thenReturn(cFakeSuccessJob(fakeChestRecord.id));

          final result = await createChestJob().run();

          cExpectSuccess(result, fakeChestRecord.id);
        }),
      );

      test(
        requirement(
          When: 'create chest fails',
          Then: 'returns failure with [unknown] exception',
        ),
        procedure(() async {
          when(mockCreateChest)
              .thenReturn(cFakeFailureJob(CRawChestCreationException.unknown));

          final result = await createChestJob().run();
          cExpectFailure(result, CChestCreationException.unknown);
        }),
      );
    });
  });
}
