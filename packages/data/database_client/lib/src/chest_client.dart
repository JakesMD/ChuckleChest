import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cpub/bobs_jobs.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

/// {@template CChestClient}
///
/// The client to interact with the chest API.
///
/// {@endtemplate}
class CChestClient {
  /// {@macro CChestClient}
  const CChestClient({required this.chestsTable});

  /// The table that represents the `chests` table in the database.
  final CChestsTable chestsTable;

  /// Creates a new chest with the given `chestName`.
  BobsJob<CRawChestCreationException, String> createChest({
    required String chestName,
  }) =>
      BobsJob.attempt(
        run: () => chestsTable.insert(
          records: [CChestsTableInsert(name: chestName)],
          columns: {CChestsTable.id},
          modifier: chestsTable.limit(1).single(),
        ),
        onError: CRawChestCreationException.fromError,
      ).then(run: (record) => record.id);
}
