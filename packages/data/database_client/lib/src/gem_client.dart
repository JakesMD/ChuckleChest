import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:supabase/supabase.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

/// {@template CGemClient}
///
/// The client to interact with the gems API.
///
/// {@endtemplate}
class CGemClient {
  /// {@macro CGemClient}
  const CGemClient({
    required this.gemsTable,
    required this.linesTable,
    required this.gemShareTokensTable,
    required this.supabaseClient,
  });

  /// The table that represents the `gems` table in the database.
  final CGemsTable gemsTable;

  /// The table that represents the `lines` table in the database.
  final CLinesTable linesTable;

  /// The table that represents the `gem_share_tokens` table in the database.
  final CGemShareTokensTable gemShareTokensTable;

  /// The supabase client.
  final SupabaseClient supabaseClient;

  /// Fetches the gem years for the given `chestID` from the database.
  BobsJob<CRawGemYearsFetchException, List<int>> fetchGemYears({
    required String chestID,
  }) =>
      BobsJob.attempt(
        run: () async {
          final response = await supabaseClient.rpc<List<dynamic>>(
            'fetch_distinct_gem_years',
            params: {'chest_id_param': chestID},
          );
          return response.cast<int>();
        },
        onError: CRawGemYearsFetchException.fromError,
      );

  /// Fetches the gem IDs for the given `chestID` and `year` from the database.
  BobsJob<CRawGemIDsFetchException, List<String>> fetchGemIDsForYear({
    required String chestID,
    required int year,
  }) =>
      BobsJob.attempt(
        run: () => gemsTable.fetchValues(
          column: CGemsTable.id,
          filter: gemsTable
              .where(CGemsTable.chestID.equals(chestID))
              .and(CGemsTable.occurredAt.greaterOrEqual(DateTime(year)))
              .and(CGemsTable.occurredAt.less(DateTime(year + 1))),
          modifier: gemsTable.order(CGemsTable.occurredAt, ascending: false),
        ),
        onError: CRawGemIDsFetchException.fromError,
      );

  /// Fetches the most recent `limit` gem IDs for the given `chestID` from the
  /// database.
  BobsJob<CRawGemIDsFetchException, List<String>> fetchRecentGemIDs({
    required String chestID,
    required int limit,
  }) =>
      BobsJob.attempt(
        run: () => gemsTable.fetchValues(
          column: CGemsTable.id,
          filter: CGemsTable.chestID.equals(chestID),
          modifier: gemsTable
              .order(CGemsTable.createdAt, ascending: false)
              .limit(limit),
        ),
        onError: CRawGemIDsFetchException.fromError,
      );

  /// Fetches the gem with the given `gemID` from the database.
  BobsJob<CRawGemFetchException, CRawGem> fetchGem({required String gemID}) =>
      BobsJob.attempt(
        run: () => gemsTable.fetchModel(
          modelBuilder: CRawGem.builder,
          filter: CGemsTable.id.equals(gemID),
        ),
        onError: CRawGemFetchException.fromError,
      );

  /// Saves the gem to the database.
  ///
  /// If the gem already exists, it will be updated. If the gem does not exist,
  /// it will be created.
  BobsJob<CRawGemSaveException, String> saveGem({
    required CGemsTableUpsert gem,
    required List<BigInt> deletedLineIDs,
    required List<CLinesTableInsert> lines,
  }) =>
      BobsJob.attempt(
        run: () => gemsTable
            .upsertAndFetchValue(upserts: [gem], column: CGemsTable.id),
        onError: CRawGemSaveException.fromError,
      )
          .thenAttempt(
            run: (gemID) async {
              await linesTable.delete(
                filter: CLinesTable.id.includedIn(deletedLineIDs),
                modifier: linesTable.none(),
              );
              return gemID;
            },
            onError: CRawGemSaveException.fromError,
          )
          .thenAttempt(
            run: (gemID) async {
              await linesTable.insert(
                inserts: lines
                    .where((line) => line.id == null)
                    .map(
                      (line) => CLinesTableInsert(
                        id: line.id,
                        gemID: gemID,
                        chestID: gem.chestID,
                        text: line.text,
                        personID: line.personID,
                      ),
                    )
                    .toList(),
                modifier: linesTable.none(),
              );
              return gemID;
            },
            onError: CRawGemSaveException.fromError,
          )
          .thenAttempt(
            run: (gemID) async {
              await linesTable.upsert(
                upserts: lines
                    .where((line) => line.id != null)
                    .map(
                      (line) => CLinesTableInsert(
                        id: line.id,
                        gemID: gemID,
                        chestID: gem.chestID,
                        text: line.text,
                        personID: line.personID,
                      ),
                    )
                    .toList(),
                modifier: linesTable.none(),
              );
              return gemID;
            },
            onError: CRawGemSaveException.fromError,
          );

  /// Fetches the `limit` gem IDs by random for the given `chestID` from the
  /// database.
  BobsJob<CRawRandomGemIDsFetchException, List<String>> fetchRandomGemIDs({
    required String chestID,
    required int limit,
  }) =>
      BobsJob.attempt(
        run: () async {
          final response = await supabaseClient.rpc<List<dynamic>>(
            'fetch_random_gem_ids',
            params: {'chest_id_param': chestID, 'limit_param': limit},
          );
          return response.cast<String>();
        },
        onError: CRawRandomGemIDsFetchException.fromError,
      );

  /// Fetches the gem with the given `shareToken` from the database.
  BobsJob<CRawGemFetchFromShareTokenException, (CRawGem, List<CRawPerson>)>
      fetchGemFromShareToken({
    required String shareToken,
  }) =>
          BobsJob.attempt(
            run: () async {
              final response = await supabaseClient.rpc<Map<String, dynamic>>(
                'fetch_gem_from_share_token',
                params: {'share_token_param': shareToken},
              );

              return (
                CRawGem(response['gem'] as Map<String, dynamic>),
                List.castFrom<dynamic, Map<String, dynamic>>(
                  response['people'] as List<dynamic>,
                ).map(CRawPerson.new).toList(),
              );
            },
            onError: CRawGemFetchFromShareTokenException.fromError,
          );

  /// Creates a share link for the a gem.
  ///
  /// Inserts the given `record` into the `gem_share_tokens` table.
  BobsJob<CRawGemShareTokenInsertException, CRawGemShareToken>
      createGemShareToken({required CGemShareTokensTableInsert record}) =>
          BobsJob.attempt(
            run: () => gemShareTokensTable.insertAndFetchModel(
              inserts: [record],
              modelBuilder: CRawGemShareToken.builder,
            ),
            onError: CRawGemShareTokenInsertException.fromError,
          );
}
