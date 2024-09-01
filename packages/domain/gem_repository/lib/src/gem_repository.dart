import 'dart:ui';

import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:cplatform_client/cplatform_client.dart';
import 'package:cpub/bobs_jobs.dart';

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

  /// The client for interacting with the gems API.
  final CGemClient gemClient;

  /// The client for interacting with the platform.
  final CPlatformClient platformClient;

  /// Fetches the gem with the given [gemID].
  BobsJob<CGemFetchException, CGem> fetchGem({required String gemID}) =>
      gemClient.fetchGem(gemID: gemID).thenEvaluate(
            onFailure: CGemFetchException.fromRaw,
            onSuccess: CGem.fromRecord,
          );

  /// Shares the gem with the given [gemID].
  BobsJob<CGemShareException, CGemShareMethod> shareGem({
    required String gemID,
    required Rect sharePositionOrigin,
    required String Function(String link) message,
    required String subject,
  }) {
    final link = 'https://jakesmd.github.io/ChuckleChest/#/gems/$gemID';

    if (platformClient.deviceType == CDeviceType.mobile ||
        platformClient.deviceType == CDeviceType.mobileWeb) {
      return platformClient
          .share(
            text: message(link),
            subject: subject,
            sharePositionOrigin:
                sharePositionOrigin, // This is required for iPads.
          )
          .thenEvaluate(
            onFailure: CGemShareException.fromRaw,
            onSuccess: (_) => CGemShareMethod.dialog,
          );
    }

    return platformClient.copyToClipboard(text: link).thenEvaluate(
          onFailure: CGemShareException.fromRaw,
          onSuccess: (_) => CGemShareMethod.clipboard,
        );
  }
}
