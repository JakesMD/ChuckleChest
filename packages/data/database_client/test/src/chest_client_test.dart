import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cpub/bobs_jobs.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/mocktail.dart';
import 'package:cpub_dev/test_beautifier.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

class MockCChestsTable extends Mock implements CChestsTable {}

class FakeCChestsTableRecord extends Fake implements CChestsTableRecord {
  @override
  String get id => 'asdjklas';
}

// ignore: missing_override_of_must_be_overridden
class FakeSupaSingleModifier extends Fake
    implements SupaSingleModifier<CChestsTableCore, CChestsTableRecord> {}

// ignore: missing_override_of_must_be_overridden
class FakeSupaLimitModifier extends Fake
    implements SupaLimitModifier<CChestsTableCore, CChestsTableRecord> {}

void main() {
  group('CChestClient Tests', () {
    final table = MockCChestsTable();
    final client = CChestClient(chestsTable: table);

    final fakeChestRecord = FakeCChestsTableRecord();

    setUpAll(() {
      registerFallbackValue(FakeSupaSingleModifier());
      registerFallbackValue(FakeSupaLimitModifier());
    });

    group('createChest', () {
      Future<CChestsTableRecord> mockInsert() => table.insert(
            records: any(named: 'records'),
            columns: any(named: 'columns'),
            modifier: any(named: 'modifier'),
          );

      BobsJob<CRawChestCreationException, String> createChestJob() =>
          client.createChest(chestName: 'asdjkl');

      setUp(() {
        when(() => table.limit(any())).thenReturn(FakeSupaLimitModifier());
      });

      test(
        requirement(
          When: 'create chest succeeds',
          Then: 'returns chest ID',
        ),
        procedure(() async {
          when(mockInsert).thenAnswer((_) async => fakeChestRecord);

          final result = await createChestJob().run();

          bobsExpectSuccess(result, fakeChestRecord.id);
        }),
      );

      test(
        requirement(
          When: 'create chest fails',
          Then: 'returns `unknown` exception',
        ),
        procedure(() async {
          when(mockInsert).thenThrow(Exception());

          final result = await createChestJob().run();

          bobsExpectFailure(result, CRawChestCreationException.unknown);
        }),
      );
    });
  });
}
