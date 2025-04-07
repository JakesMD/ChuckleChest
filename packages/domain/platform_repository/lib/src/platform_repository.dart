import 'dart:typed_data';

import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:ccore/ccore.dart';
import 'package:cplatform_client/cplatform_client.dart'
    hide CImagePickException;
import 'package:cplatform_repository/cplatform_repository.dart';
import 'package:image/image.dart' as img;

/// {@template CPlatformRepository}
///
/// The repository for platform information.
///
/// {@endtemplate}
class CPlatformRepository {
  /// {@macro CPlatformRepository}
  const CPlatformRepository({required this.platformClient});

  /// The platform client.
  final CPlatformClient platformClient;

  /// Allows the user to pick an image from their gallery.
  ///
  /// If the user cancels the image pick it will return a `BobsAbsent`.
  BobsJob<CImagePickException, BobsMaybe<Uint8List>> pickImage({
    required CImagePickSource source,
    int? width,
    int? height,
  }) =>
      platformClient
          .pickImage(
            source: source,
            maxWidth: width ?? 1000,
            maxHeight: height ?? 1000,
          )
          .thenConvertFailure(CImagePickException.fromFailure)
          .thenAttempt(
            run: (image) => image.resolve(
              onAbsent: bobsAbsent,
              onPresent: (image) async {
                final command = img.Command()
                  ..decodeImage(image)
                  ..encodeJpg();

                // This will throw if the image could not be decoded, which is
                // what we want.
                final bytes = (await command.executeThread()).outputBytes!;
                return bobsPresent(bytes);
              },
            ),
            onError: CImagePickException.fromError,
          );
}
