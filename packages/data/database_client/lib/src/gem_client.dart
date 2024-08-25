import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

/// {@template CGemClient}
///
/// The client to interact with the gems API.
///
/// {@endtemplate}
class CGemClient {
  /// {@macro CGemClient}
  const CGemClient({required this.gemsTable});

  /// The table that represents the `gems` table in the database.
  final CGemsTable gemsTable;

  /// Fetches the gem with the given `gemID` from the database.
  ///
  /// If `withAvatarURLs` is `true`, the gem will include the avatar URLs.
  CJob<CRawGemFetchException, CGemsTableRecord> fetchGem({
    required String gemID,
    bool withAvatarURLs = false,
  }) =>
      CJob.attempt(
        run: () => gemsTable.fetch(
          columns: {
            CGemsTable.id,
            CGemsTable.number,
            CGemsTable.occurredAt,
            CGemsTable.lines({
              CLinesTable.id,
              CLinesTable.text,
              CLinesTable.person({
                CPeopleTable.id,
                CPeopleTable.nickname,
                CPeopleTable.dateOfBirth,
                if (withAvatarURLs) CPeopleTable.avatarURLs,
              }),
            }),
          },
          filter: gemsTable.equal(CGemsTable.id(gemID)),
          modifier: gemsTable.limit(1).single(),
        ),
        onError: CRawGemFetchException.fromError,
      );
}
