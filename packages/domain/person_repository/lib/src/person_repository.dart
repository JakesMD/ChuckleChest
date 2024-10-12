import 'dart:async';
import 'dart:typed_data';

import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:cplatform_client/cplatform_client.dart';
import 'package:cstorage_client/cstorage_client.dart';
import 'package:image/image.dart' as img;

/// {@template CPersonRepository}
///
/// A repository for managing people.
///
/// {@endtemplate}
class CPersonRepository {
  /// {@macro CPersonRepository}
  const CPersonRepository({
    required this.personClient,
    required this.storageClient,
    required this.platformClient,
  });

  /// The client for interacting with the people API.
  final CPersonClient personClient;

  /// The client for interacting with the storage API.
  final CStorageClient storageClient;

  /// The client for interacting with the platform API.
  final CPlatformClient platformClient;

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

  /// Updates the avatar for the given `year` for the given `person` and returns
  /// the URL of the new avatar.
  ///
  /// If the an image for the given `year` already exists, it will be replaced.
  BobsJob<CAvatarUpdateException, String> updateAvatar({
    required BigInt personID,
    required String chestID,
    required int year,
    required Uint8List image,
  }) =>
      BobsJob.attempt(
        run: () async {
          final command = img.Command()
            ..decodeImage(image)
            ..copyResize(
              width: 200,
              height: 200,
              maintainAspect: true,
            )
            ..encodeJpg();
          return (await command.executeThread()).outputBytes!;
        },
        onError: CAvatarUpdateException.fromError,
      ).chainOnSuccess(
        onFailure: (f) => f,
        nextJob: (resizedImage) => storageClient
            .uploadAvatar(
              chestID: chestID,
              personID: personID,
              year: year,
              avatarFile: resizedImage,
            )
            .chainOnSuccess(
              onFailure: CAvatarUpdateException.fromRaw,
              nextJob: (imageURL) => personClient
                  .upsertAvatar(
                    avatar: CAvatarsTableInsert(
                      personID: personID,
                      year: year,
                      imageURL: imageURL,
                      chestID: chestID,
                    ),
                  )
                  .thenEvaluate(
                    onFailure: CAvatarUpdateException.fromRaw,
                    onSuccess: (_) => imageURL,
                  ),
            ),
      );

  /// Allows the user to pick an image from their gallery.
  ///
  /// If the user cancels the image pick it will return a `BobsAbsent`.
  BobsJob<CAvatarPickException, BobsMaybe<Uint8List>> pickAvatar() =>
      platformClient
          .pickImage(maxHeight: 1000, maxWidth: 1000)
          .thenEvaluateOnFailure(CAvatarPickException.fromRaw);

  /// Creates a default person with the given `chestID`.
  BobsJob<CPersonCreationException, CPerson> createPerson({
    required String chestID,
  }) =>
      personClient.insertPerson(chestID: chestID).thenEvaluate(
            onFailure: CPersonCreationException.fromRaw,
            onSuccess: CPerson.fromRecord,
          );
}
