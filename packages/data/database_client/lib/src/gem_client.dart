import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

/// {@template CGemClient}
///
/// The client to interact with the gems API.
///
/// {@endtemplate}
class CGemClient {
  /// {@macro CGemClient}
  const CGemClient({required this.gemsTable, required this.linesTable});

  /// The table that represents the `gems` table in the database.
  final CGemsTable gemsTable;

  /// The table that represents the `lines` table in the database.
  final CLinesTable linesTable;

  /// Fetches the gem years for the given `chestID` from the database.
  BobsJob<CRawGemYearsFetchException, List<int>> fetchGemYears({
    required String chestID,
  }) =>
      BobsJob.attempt(
        run: () async {
          final response = await gemsTable.supabaseClient.rpc<List<dynamic>>(
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
        run: () async {
          final response = await gemsTable.fetch(
            columns: {CGemsTable.id},
            filter: gemsTable
                .equal(CGemsTable.chestID(chestID))
                .greaterOrEqual(CGemsTable.occurredAt(DateTime(year)))
                .less(CGemsTable.occurredAt(DateTime(year + 1))),
            modifier: gemsTable.order(CGemsTable.occurredAt, ascending: false),
          );
          return response.map((r) => r.id).toList();
        },
        onError: CRawGemIDsFetchException.fromError,
      );

  /// Fetches the most recent `limit` gem IDs for the given `chestID` from the
  /// database.
  BobsJob<CRawGemIDsFetchException, List<String>> fetchRecentGemIDs({
    required String chestID,
    required int limit,
  }) =>
      BobsJob.attempt(
        run: () async {
          final response = await gemsTable.fetch(
            columns: {CGemsTable.id},
            filter: gemsTable.equal(CGemsTable.chestID(chestID)),
            modifier: gemsTable
                .order(CGemsTable.occurredAt, ascending: false)
                .limit(limit),
          );
          return response.map((r) => r.id).toList();
        },
        onError: CRawGemIDsFetchException.fromError,
      );

  /// Fetches the gem with the given `gemID` from the database.
  BobsJob<CRawGemFetchException, CGemsTableRecord> fetchGem({
    required String gemID,
  }) =>
      BobsJob.attempt(
        run: () => gemsTable.fetch(
          columns: {
            CGemsTable.id,
            CGemsTable.chestID,
            CGemsTable.number,
            CGemsTable.occurredAt,
            CGemsTable.lines,
          },
          filter: gemsTable.equal(CGemsTable.id(gemID)),
          modifier: gemsTable.limit(1).single(),
        ),
        onError: CRawGemFetchException.fromError,
      );

  /// Saves the gem to the database.
  ///
  /// If the gem already exists, it will be updated. If the gem does not exist,
  /// it will be created.
  BobsJob<CRawGemSaveException, String> saveGem({
    required CGemsTableInsert gem,
    required List<BigInt> deletedLineIDs,
    required List<CLinesTableInsert> lines,
  }) =>
      BobsJob.attempt(
        run: () async {
          final response = await gemsTable.upsert(
            records: [gem],
            columns: {CGemsTable.id},
            modifier: gemsTable.limit(1).single(),
          );
          return response.id;
        },
        onError: CRawGemSaveException.fromError,
      )
          .thenAttempt(
            run: (gemID) async {
              await linesTable.delete(
                filter: linesTable.includedIn(CLinesTable.id, deletedLineIDs),
                modifier: linesTable.none(),
              );

              return gemID;
            },
            onError: CRawGemSaveException.fromError,
          )
          .thenAttempt(
            run: (gemID) async {
              await linesTable.upsert(
                records: lines
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
}
