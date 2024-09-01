import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cperson_repository/cperson_repository.dart';

/// {@template CPersonRepository}
///
/// A repository for managing people.
///
/// {@endtemplate}
class CPersonRepository {
  /// {@macro CPersonRepository}
  const CPersonRepository({
    required this.personClient,
  });

  /// The client for interacting with the people API.
  final CPersonClient personClient;

  /// Fetches all the people belonging to the chest with the given `chestID`.
  CJob<CChestPeopleFetchException, List<CPerson>> fetchChestPeople({
    required String chestID,
  }) =>
      personClient.fetchChestPeople(chestID: chestID).thenEvaluate(
            onFailure: CChestPeopleFetchException.fromRaw,
            onSuccess: (records) => records.map(CPerson.fromRecord).toList(),
          );
}
