import 'dart:async';

import 'package:bobs_jobs/bobs_jobs.dart';
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
  BobsJob<CChestPeopleFetchException, List<CPerson>> fetchChestPeople({
    required String chestID,
  }) =>
      personClient.fetchChestPeople(chestID: chestID).thenEvaluate(
            onFailure: CChestPeopleFetchException.fromRaw,
            onSuccess: (records) => records.map(CPerson.fromRecord).toList(),
          );

  /// Updates the person with the same ID.
  BobsJob<CPersonUpdateException, BobsNothing> updatePerson({
    required CPerson person,
  }) =>
      personClient
          .updatePerson(
            personID: person.id,
            nickname: person.nickname,
            dateOfBirth: person.dateOfBirth,
          )
          .thenEvaluate(
            onFailure: CPersonUpdateException.fromRaw,
            onSuccess: (_) => bobsNothing,
          );

  /// Streams the person with the given `personID`.
  Stream<BobsOutcome<CPersonStreamException, CPerson>> personStream({
    required BigInt personID,
  }) =>
      personClient.personStream(personID: personID).map(
            (outcome) => outcome.evaluate(
              onFailure: (e) => bobsFailure(CPersonStreamException.fromRaw(e)),
              onSuccess: (r) => bobsSuccess(CPerson.fromRecord(r)),
            ),
          );

  /// Upserts an avatar for the given person.
  BobsJob<CAvatarUpsertException, BobsNothing> upsertAvatar({
    required CPerson person,
    required String imageURL,
    required int year,
  }) =>
      personClient
          .upsertAvatar(
            avatar: CAvatarsTableInsert(
              personID: person.id,
              year: year,
              imageURL: imageURL,
              chestID: person.chestID,
            ),
          )
          .thenEvaluate(
            onFailure: CAvatarUpsertException.fromRaw,
            onSuccess: (_) => bobsNothing,
          );

  /// Creates a default person with the given `chestID`.
  BobsJob<CPersonCreationException, CPerson> createPerson({
    required String chestID,
  }) =>
      personClient.insertPerson(chestID: chestID).thenEvaluate(
            onFailure: CPersonCreationException.fromRaw,
            onSuccess: CPerson.fromRecord,
          );
}
