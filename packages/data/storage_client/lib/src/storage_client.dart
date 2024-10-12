import 'dart:typed_data';

import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cstorage_client/cstorage_client.dart';
import 'package:supabase/supabase.dart';

/// {@template CStorageClient}
///
/// The client that interacts with the Supabase storage API.
///
/// It is used to upload avatars for people in the chest.
///
/// {@endtemplate}
class CStorageClient {
  /// {@macro CStorageClient}
  const CStorageClient({required this.supabaseClient});

  /// The Supabase client to use for storage operations.
  final SupabaseClient supabaseClient;

  /// Uploads the avatar file for the person with the given [personID] in the
  /// chest with the given [chestID] and [year].
  ///
  /// Returns the signed URL for the uploaded file.
  ///
  /// If the user already has an avatar for the given year, it will be
  /// overwritten.
  BobsJob<CRawAvatarUploadException, String> uploadAvatar({
    required String chestID,
    required BigInt personID,
    required int year,
    required Uint8List avatarFile,
  }) =>
      BobsJob.attempt(
        run: () => supabaseClient.storage.from('avatars').uploadBinary(
              'chests/$chestID/$personID-$year.jpg',
              avatarFile,
              fileOptions: const FileOptions(upsert: true),
            ),
        onError: CRawAvatarUploadException.fromError,
      ).thenAttempt(
        run: (path) => supabaseClient.storage.from('avatars').createSignedUrl(
              path.replaceFirst('avatars/', ''),
              60 * 60 * 24 * 365 * 100,
            ),
        onError: CRawAvatarUploadException.fromError,
      );
}
