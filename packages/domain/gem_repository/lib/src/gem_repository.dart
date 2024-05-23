import 'dart:ui';

import 'package:cgem_client/cgem_client.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:cplatform_client/cplatform_client.dart';
import 'package:cpub/dartz.dart';

/// {@template CGemRepository}
///
/// A repository for managing gems.
///
/// {@endtemplate}
class CGemRepository {
  /// {@macro CGemRepository}
  const CGemRepository({
    required this.gemClient,
    required this.platformClient,
  });

  /// The client for interacting with the gem API.
  final CGemClient gemClient;

  /// The client for interacting with the platform.
  final CPlatformClient platformClient;

  /// Fetches the gem with the given [gemID].
  Future<Either<CGemFetchException, CGem>> fetchGem({
    required String gemID,
  }) async {
    final result = await gemClient.fetchGem(
      gemID: gemID,
      withAvatarURLs: false,
    );

    return result.fold(
      (exception) => left(
        switch (exception) {
          CRawGemFetchException.notFound => CGemFetchException.notFound,
          CRawGemFetchException.unknown => CGemFetchException.unknown,
        },
      ),
      (rawGem) => right(CGem.fromRaw(rawGem)),
    );
  }

  /// Shares the gem with the given [gemID].
  Future<Either<CGemShareException, CGemShareMethod>> shareGem({
    required String gemID,
    required Rect sharePositionOrigin,
    required String Function(String link) message,
    required String subject,
  }) async {
    final link = 'https://jakesmd.github.io/ChuckleChest/gems/$gemID';

    if (platformClient.deviceType == CDeviceType.mobile) {
      final result = await platformClient.share(
        text: message(link),
        subject: subject,
        sharePositionOrigin: sharePositionOrigin, // This is required for iPads.
      );

      return result.fold(
        (exception) => left(
          switch (exception) {
            CShareException.unknown => CGemShareException.unknown
          },
        ),
        (_) => right(CGemShareMethod.dialog),
      );
    }

    final result = await platformClient.copyToClipboard(text: link);

    return result.fold(
      (exception) => left(
        switch (exception) {
          CClipboardCopyException.unknown => CGemShareException.unknown
        },
      ),
      (_) => right(CGemShareMethod.clipboard),
    );
  }
}
