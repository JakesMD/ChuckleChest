// Exceptions are unknown.
// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:async';

import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

/// {@template CPersonClient}
///
/// The client to interact with the person API.
///
/// {@endtemplate}
class CPersonClient {
  /// {@macro CPersonClient}
  const CPersonClient({required this.peopleTable, required this.avatarsTable});

  /// The table that represents the `people` table in the database.
  final CPeopleTable peopleTable;

  /// The table that represents the `avatars` table in the database.
  final CAvatarsTable avatarsTable;

  /// Fetches all the people belonging to th chest with the given `chestID`.
  BobsJob<CRawChestPeopleFetchException, List<CRawPerson>> fetchChestPeople({
    required String chestID,
  }) =>
      BobsJob.attempt(
        run: () => peopleTable.fetchModels(
          modelBuilder: CRawPerson.builder,
          filter: CPeopleTable.chestID.equals(chestID),
          modifier: peopleTable.order(CPeopleTable.nickname),
        ),
        onError: CRawChestPeopleFetchException.fromError,
      );

  /// Updates the person with the given `personID`.
  BobsJob<CRawPersonUpdateException, BobsNothing> updatePerson({
    required BigInt personID,
    required String? nickname,
    required DateTime? dateOfBirth,
  }) =>
      BobsJob.attempt(
        run: () => peopleTable.update(
          values: [
            if (nickname != null) CPeopleTable.nickname(nickname),
            if (dateOfBirth != null) CPeopleTable.dateOfBirth(dateOfBirth),
          ],
          filter: CPeopleTable.id.equals(personID),
        ),
        onError: CRawPersonUpdateException.fromError,
      ).thenConvert(onFailure: (e) => e, onSuccess: (_) => bobsNothing);

  /// Streams the person with the given `personID`.
  Stream<BobsOutcome<CRawPersonStreamException, CRawPerson>> personStream({
    required BigInt personID,
  }) async* {
    try {
      final transformer = StreamTransformer<CRawPerson,
          BobsOutcome<CRawPersonStreamException, CRawPerson>>.fromHandlers(
        handleData: (data, sink) => sink.add(bobsSuccess(data)),
        handleError: (e, s, sink) =>
            sink.add(bobsFailure(CRawPersonStreamException.fromError(e))),
        handleDone: (sink) => sink.close(),
      );

      final stream = peopleTable
          .streamModel(
            modelBuilder: CRawPerson.builder,
            filter: CPeopleTable.id.streamEquals(personID),
          )
          .transform(transformer);

      yield* stream;
    } catch (e) {
      yield bobsFailure(CRawPersonStreamException.fromError(e));
    }
  }

  /// Updates or inserts the given `avatar`.
  BobsJob<CRawAvatarUpsertException, BobsNothing> upsertAvatar({
    required CAvatarsTableUpsert avatar,
  }) =>
      BobsJob.attempt(
        run: () => avatarsTable.upsert(
          upserts: [avatar],
          filter: CAvatarsTable.personID.equals(avatar.personID),
        ),
        onError: CRawAvatarUpsertException.fromError,
      ).thenConvert(onFailure: (e) => e, onSuccess: (_) => bobsNothing);

  /// Streams all the avatars belonging to the person with the given `personID`.
  BobsJob<CRawAvatarsStreamException, Stream<List<CRawPersonAvatar>>>
      avatarsStream({required BigInt personID}) => BobsJob.attempt(
            run: () => avatarsTable.streamModels(
              modelBuilder: CRawPersonAvatar.builder,
              filter: CAvatarsTable.personID.streamEquals(personID),
              modifier: avatarsTable.orderStream(CAvatarsTable.year),
            ),
            onError: CRawAvatarsStreamException.fromError,
          );

  /// Inserts a new person with the given `chestID`.
  BobsJob<CRawPersonInsertException, CRawPerson> insertPerson({
    required String chestID,
  }) =>
      BobsJob.attempt(
        run: () => peopleTable.insertAndFetchModel(
          inserts: [
            CPeopleTableInsert(
              chestID: chestID,
              nickname: 'New Person',
              dateOfBirth: DateTime.now(),
            ),
          ],
          modelBuilder: CRawPerson.builder,
        ),
        onError: CRawPersonInsertException.fromError,
      ).thenConvert(onFailure: (e) => e, onSuccess: (person) => person);
}
