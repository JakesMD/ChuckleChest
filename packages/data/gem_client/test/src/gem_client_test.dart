import 'package:cgem_client/cgem_client.dart';
import 'package:cpub/dartz.dart';
import 'package:cpub/supabase.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/mocktail.dart';
import 'package:cpub_dev/test_beautifier.dart';
import 'package:csupabase_client/csupabase_client.dart';

void main() {
  group('CGemClient tests', () {
    late MockCSupabaseClient supabaseClient;
    late CGemClient client;

    const fakeAvatarURL = CRawAvatarURL(url: 'asdfasf', age: 21);

    final fakeConnection = CRawConnection(
      nickname: 'asfdasdf',
      dateOfBirth: DateTime(2003),
      avatarURLs: [fakeAvatarURL],
    );

    final fakeNarration = CRawLine(
      id: BigInt.from(123),
      text: 'gfsdgdfagsd',
      connection: null,
    );

    final fakeQuote = CRawLine(
      id: BigInt.from(123),
      text: 'adgfdhfagsfd',
      connection: fakeConnection,
    );

    final fakeGem = CRawGem(
      id: 'asdfadsf',
      number: 1,
      occurredAt: DateTime(2024),
      lines: [fakeNarration, fakeQuote],
    );

    setUp(() {
      supabaseClient = MockCSupabaseClient();
      client = CGemClient(supabaseClient: supabaseClient);
    });

    group('fetchGem', () {
      Future<Either<CRawGemFetchException, CRawGem>> fetchGem() {
        return client.fetchGem(gemID: fakeGem.id, withAvatarURLs: true);
      }

      test(
        requirement(
          Given: 'gem in database',
          When: 'fetch gem with avatar URLs',
          Then: 'returns gem with avatar URLs',
        ),
        procedure(() async {
          when(supabaseClient.mockFetchSingle).thenAnswer(
            (_) async => {
              'id': fakeGem.id,
              'number': fakeGem.number,
              'occurred_at': fakeGem.occurredAt.toIso8601String(),
              'lines': [
                {
                  'id': fakeNarration.id.toInt(),
                  'text': fakeNarration.text,
                  'connection': null,
                },
                {
                  'id': fakeQuote.id.toInt(),
                  'text': fakeQuote.text,
                  'connections': {
                    'nickname': fakeConnection.nickname,
                    'date_of_birth':
                        fakeConnection.dateOfBirth.toIso8601String(),
                    'connection_avatar_urls': [
                      {
                        'avatar_url': fakeAvatarURL.url,
                        'age': fakeAvatarURL.age,
                      },
                    ],
                  },
                },
              ],
            },
          );

          final gem = await fetchGem();

          expect(gem, right(fakeGem));
        }),
      );

      test(
        requirement(
          When: 'fetch gem fails',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(supabaseClient.mockFetchSingle).thenThrow(Exception());

          final gem = await fetchGem();

          expect(gem, left(CRawGemFetchException.unknown));
        }),
      );

      test(
        requirement(
          When: 'fetch gem fails wiht unknown postgrest exception',
          Then: 'returns [unknown] exception',
        ),
        procedure(() async {
          when(supabaseClient.mockFetchSingle).thenThrow(
            const PostgrestException(message: ''),
          );

          final gem = await fetchGem();

          expect(gem, left(CRawGemFetchException.unknown));
        }),
      );

      test(
        requirement(
          Given: 'gem with ID does not exist',
          When: 'fetch gem',
          Then: 'returns [notFound] exception',
        ),
        procedure(() async {
          when(supabaseClient.mockFetchSingle).thenThrow(
            const PostgrestException(message: '', code: 'PGRST116'),
          );

          final gem = await fetchGem();

          expect(gem, left(CRawGemFetchException.notFound));
        }),
      );

      test(
        requirement(
          When: 'fetch gem with invalid UUID',
          Then: 'returns [notFound] exception',
        ),
        procedure(() async {
          when(supabaseClient.mockFetchSingle).thenThrow(
            const PostgrestException(message: '', code: '22P02'),
          );

          final gem = await fetchGem();

          expect(gem, left(CRawGemFetchException.notFound));
        }),
      );
    });
  });
}
