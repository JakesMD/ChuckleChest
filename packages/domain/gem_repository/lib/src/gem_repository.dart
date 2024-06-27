import 'dart:ui';

import 'package:ccore/ccore.dart';
import 'package:cgem_client/cgem_client.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:cplatform_client/cplatform_client.dart';

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
  CJob<CGemFetchException, CGem> fetchGem({required String gemID}) {
    return gemClient.fetchGem(gemID: gemID, withAvatarURLs: false).thenEvaluate(
          onFailure: CGemFetchException.fromRaw,
          onSuccess: CGem.fromRaw,
        );
  }

  /// Shares the gem with the given [gemID].
  CJob<CGemShareException, CGemShareMethod> shareGem({
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
