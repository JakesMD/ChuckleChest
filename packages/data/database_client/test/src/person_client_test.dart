import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cpub/bobs_jobs.dart';
import 'package:cpub/supabase.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/mocktail.dart';
import 'package:cpub_dev/test_beautifier.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

class MockCPeopleTable extends Mock implements CPeopleTable {}

class FakeCPeopleTableRecord extends Fake implements CPeopleTableRecord {}

// ignore: missing_override_of_must_be_overridden
class FakeSupaFilter extends Fake implements SupaFilter<CPeopleTableCore> {}

// ignore: missing_override_of_must_be_overridden
class FakeSupaOrderModifier extends Fake
    implements SupaOrderModifier<CPeopleTableCore, CPeopleTableRecord> {}

void main() {
  group('CPersonClient Tests', () {
    final table = MockCPeopleTable();
    final client = CPersonClient(peopleTable: table);

    final fakePersonRecord = FakeCPeopleTableRecord();

    setUpAll(() {
      registerFallbackValue(FakeSupaFilter());
      registerFallbackValue(FakeSupaOrderModifier());
      registerFallbackValue(CPeopleTable.chestID(''));
      registerFallbackValue(CPeopleTable.nickname);
    });

    group('fetchChestPeople', () {
      Future<List<CPeopleTableRecord>> mockFetch() => table.fetch(
            columns: any(named: 'columns'),
            filter: any(named: 'filter'),
            modifier: any(named: 'modifier'),
          );

      BobsJob<CRawChestPeopleFetchException, List<CPeopleTableRecord>>
          fetchChestPeopleJob() => client.fetchChestPeople(chestID: 'asdasda');

      setUp(() {
        when(() => table.equal(any())).thenReturn(FakeSupaFilter());
        when(() => table.order(any())).thenReturn(FakeSupaOrderModifier());
      });

      test(
        requirement(
          When: 'fetch chest people succeeds',
          Then: 'returns people',
        ),
        procedure(() async {
          final expected = [fakePersonRecord];

          when(mockFetch).thenAnswer((_) async => expected);

          final result = await fetchChestPeopleJob().run();

          bobsExpectSuccess(result, expected);
        }),
      );

      test(
        requirement(
          Given: 'invalid chest ID',
          When: 'fetch chest people',
          Then: 'returns `not found` exception',
        ),
        procedure(() async {
          when(mockFetch).thenThrow(
            const PostgrestException(message: '', code: 'PGRST116'),
          );

          final result = await fetchChestPeopleJob().run();

          bobsExpectFailure(
            result,
            CRawChestPeopleFetchException.chestNotFound,
          );
        }),
      );

      test(
        requirement(
          When: 'fetch chest people fails',
          Then: 'returns `unknown` exception',
        ),
        procedure(() async {
          when(mockFetch).thenThrow(Exception());

          final result = await fetchChestPeopleJob().run();

          bobsExpectFailure(result, CRawChestPeopleFetchException.unknown);
        }),
      );
    });
  });
}
