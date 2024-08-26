import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cpub/supabase.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/mocktail.dart';
import 'package:cpub_dev/test_beautifier.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

class MockCGemsTable extends Mock implements CGemsTable {}

class FakeCGemsTableRecord extends Fake implements CGemsTableRecord {}

// ignore: missing_override_of_must_be_overridden
class FakeSupaFilter extends Fake implements SupaFilter<CGemsTableCore> {}

// ignore: missing_override_of_must_be_overridden
class FakeSupaSingleModifier extends Fake
    implements SupaSingleModifier<CGemsTableCore, CGemsTableRecord> {}

// ignore: missing_override_of_must_be_overridden
class FakeSupaLimitModifier extends Fake
    implements SupaLimitModifier<CGemsTableCore, CGemsTableRecord> {}

void main() {
  group('CGemClient Tests', () {
    final table = MockCGemsTable();
    final client = CGemClient(gemsTable: table);

    final fakeGemRecord = FakeCGemsTableRecord();

    setUpAll(() {
      registerFallbackValue(FakeSupaFilter());
      registerFallbackValue(FakeSupaSingleModifier());
      registerFallbackValue(FakeSupaLimitModifier());
      registerFallbackValue(CGemsTable.id(''));
    });

    group('fetchGem', () {
      Future<CGemsTableRecord> mockFetch() => table.fetch(
            columns: any(named: 'columns'),
            filter: any(named: 'filter'),
            modifier: any(named: 'modifier'),
          );

      CJob<CRawGemFetchException, CGemsTableRecord> fetchGemJob() =>
          client.fetchGem(gemID: 'adsfklj');

      setUp(() {
        when(() => table.equal(any())).thenReturn(FakeSupaFilter());
        when(() => table.limit(any())).thenReturn(FakeSupaLimitModifier());
      });

      test(
        requirement(
          When: 'fetch gem succeeds',
          Then: 'returns gem',
        ),
        procedure(() async {
          when(mockFetch).thenAnswer((_) async => fakeGemRecord);

          final result = await fetchGemJob().run();

          cExpectSuccess(result, fakeGemRecord);
        }),
      );

      test(
        requirement(
          Given: 'invalid gem ID',
          When: 'fetch gem',
          Then: 'returns `not found` exception',
        ),
        procedure(() async {
          when(mockFetch).thenThrow(
            const PostgrestException(message: '', code: 'PGRST116'),
          );

          final result = await fetchGemJob().run();

          cExpectFailure(result, CRawGemFetchException.notFound);
        }),
      );

      test(
        requirement(
          When: 'fetch gem fails',
          Then: 'returns `unknown` exception',
        ),
        procedure(() async {
          when(mockFetch).thenThrow(Exception());

          final result = await fetchGemJob().run();

          cExpectFailure(result, CRawGemFetchException.unknown);
        }),
      );
    });
  });
}
