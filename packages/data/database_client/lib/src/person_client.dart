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
  BobsJob<CRawChestPeopleFetchException, List<CPeopleTableRecord>>
      fetchChestPeople({required String chestID}) => BobsJob.attempt(
            run: () => peopleTable.fetch(
              columns: {
                CPeopleTable.id,
                CPeopleTable.chestID,
                CPeopleTable.nickname,
                CPeopleTable.dateOfBirth,
                CPeopleTable.avatars({
                  CAvatarsTable.year,
                  CAvatarsTable.imageURL,
                }),
              },
              modifier: peopleTable.order(CPeopleTable.nickname),
              filter: peopleTable.equal(CPeopleTable.chestID(chestID)),
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
          values: {
            if (nickname != null) CPeopleTable.nickname(nickname),
            if (dateOfBirth != null) CPeopleTable.dateOfBirth(dateOfBirth),
          },
          filter: peopleTable.equal(CPeopleTable.id(personID)),
          modifier: peopleTable.none(),
        ),
        onError: CRawPersonUpdateException.fromError,
      ).thenEvaluate(onFailure: (e) => e, onSuccess: (_) => bobsNothing);

  /// Streams the person with the given `personID`.
  Stream<BobsOutcome<CRawPersonStreamException, CPeopleTableRecord>>
      personStream({required BigInt personID}) async* {
    try {
      final transformer = StreamTransformer<
          CPeopleTableRecord,
          BobsOutcome<CRawPersonStreamException,
              CPeopleTableRecord>>.fromHandlers(
        handleData: (data, sink) => sink.add(bobsSuccess(data)),
        handleError: (e, s, sink) =>
            sink.add(bobsFailure(CRawPersonStreamException.fromError(e, s))),
        handleDone: (sink) => sink.close(),
      );

      final stream = peopleTable
          .stream(
            filter: peopleTable.sEqual(CPeopleTable.id(personID)),
            modifier: peopleTable.sLimit(1),
          )
          .map((list) => list.first)
          .transform(transformer);

      yield* stream;
    } catch (e, s) {
      yield bobsFailure(CRawPersonStreamException.fromError(e, s));
    }
  }

  /// Updates or inserts the given `avatar`.
  BobsJob<CRawAvatarUpsertException, BobsNothing> upsertAvatar({
    required CAvatarsTableInsert avatar,
  }) =>
      BobsJob.attempt(
        run: () => avatarsTable.upsert(
          records: [avatar],
          filter: avatarsTable.equal(CAvatarsTable.personID(avatar.personID)),
          modifier: avatarsTable.none(),
        ),
        onError: CRawAvatarUpsertException.fromError,
      ).thenEvaluate(onFailure: (e) => e, onSuccess: (_) => bobsNothing);

  /// Streams all the avatars belonging to the person with the given `personID`.
  BobsJob<CRawAvatarsStreamException, Stream<List<CAvatarsTableRecord>>>
      avatarsStream({required BigInt personID}) => BobsJob.attempt(
            isAsync: false,
            run: () => avatarsTable.stream(
              filter: avatarsTable.sEqual(CAvatarsTable.personID(personID)),
              modifier: avatarsTable.sOrder(CAvatarsTable.year),
            ),
            onError: CRawAvatarsStreamException.fromError,
          );

  /// Inserts a new person with the given `chestID`.
  BobsJob<CRawPersonInsertException, CPeopleTableRecord> insertPerson({
    required String chestID,
  }) =>
      BobsJob.attempt(
        run: () => peopleTable.insert(
          records: [
            CPeopleTableInsert(
              chestID: chestID,
              nickname: 'New Person',
              dateOfBirth: DateTime.now(),
            ),
          ],
          modifier: peopleTable.limit(1).single(),
        ),
        onError: CRawPersonInsertException.fromError,
      ).thenEvaluate(onFailure: (e) => e, onSuccess: (person) => person);
}
