import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cpub/bobs_jobs.dart';

/// {@template CPersonClient}
///
/// The client to interact with the person API.
///
/// {@endtemplate}
class CPersonClient {
  /// {@macro CPersonClient}
  const CPersonClient({required this.peopleTable});

  /// The table that represents the `people` table in the database.
  final CPeopleTable peopleTable;

  /// Fetches all the people belonging to th chest with the given `chestID`.
  BobsJob<CRawChestPeopleFetchException, List<CPeopleTableRecord>>
      fetchChestPeople({required String chestID}) => BobsJob.attempt(
            run: () => peopleTable.fetch(
              columns: {
                CPeopleTable.id,
                CPeopleTable.nickname,
                CPeopleTable.dateOfBirth,
                CPeopleTable.avatarURLs({
                  CAvatarURLsTable.age,
                  CAvatarURLsTable.url,
                }),
              },
              modifier: peopleTable.order(CPeopleTable.nickname),
              filter: peopleTable.equal(CPeopleTable.chestID(chestID)),
            ),
            onError: CRawChestPeopleFetchException.fromError,
          );
}
