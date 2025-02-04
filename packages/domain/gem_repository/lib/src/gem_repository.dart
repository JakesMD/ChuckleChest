import 'dart:ui';

import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
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

  /// The client for interacting with the gems API.
  final CGemClient gemClient;

  /// The client for interacting with the platform.
  final CPlatformClient platformClient;

  /// Fetches the years of gems in the chest with the given [chestID].
  BobsJob<CGemYearsFetchException, List<int>> fetchGemYears({
    required String chestID,
  }) =>
      gemClient
          .fetchGemYears(chestID: chestID)
          .thenConvertFailure(CGemYearsFetchException.fromRaw);

  /// Fetches the IDs of gems in the chest with the given [chestID] for the
  /// given [year].
  BobsJob<CGemIDsFetchException, List<String>> fetchGemIDsForYear({
    required String chestID,
    required int year,
  }) =>
      gemClient
          .fetchGemIDsForYear(chestID: chestID, year: year)
          .thenConvertFailure(CGemIDsFetchException.fromRaw);

  /// Fetches the most recent gem IDs in the chest with the given [chestID].
  BobsJob<CGemIDsFetchException, List<String>> fetchRecentGemIDs({
    required String chestID,
  }) =>
      gemClient
          .fetchRecentGemIDs(chestID: chestID, limit: 20)
          .thenConvertFailure(CGemIDsFetchException.fromRaw);

  /// Fetches the gem with the given [gemID].
  BobsJob<CGemFetchException, CGem> fetchGem({required String gemID}) =>
      gemClient.fetchGem(gemID: gemID).thenConvert(
            onFailure: CGemFetchException.fromRaw,
            onSuccess: CGem.fromRecord,
          );

  /// Saves the gem with the given [gem], [deletedLines].
  BobsJob<CGemSaveException, String> saveGem({
    required CGem gem,
    required List<CLine> deletedLines,
  }) =>
      gemClient
          .saveGem(
            gem: gem.toInsert(),
            deletedLineIDs: deletedLines
                .where((lines) => lines.id != null)
                .map((line) => line.id!)
                .toList(),
            lines: gem.lines.map((line) => line.toInsert()).toList(),
          )
          .thenConvertFailure(CGemSaveException.fromRaw);

  /// Shares the gem with the given [shareToken].
  BobsJob<CGemShareException, CGemShareMethod> shareGem({
    required String shareToken,
    required Rect sharePositionOrigin,
    required String Function(String link) message,
    required String subject,
  }) {
    final link = 'https://chucklechest.app/app/#/shared-gem?token=$shareToken';

    if (platformClient.deviceType == CDeviceType.mobile ||
        platformClient.deviceType == CDeviceType.mobileWeb) {
      return platformClient
          .share(
            text: message(link),
            subject: subject,
            sharePositionOrigin:
                sharePositionOrigin, // This is required for iPads.
          )
          .thenConvert(
            onFailure: CGemShareException.fromRaw,
            onSuccess: (_) => CGemShareMethod.dialog,
          );
    }

    return platformClient.copyToClipboard(text: link).thenConvert(
          onFailure: CGemShareException.fromRaw,
          onSuccess: (_) => CGemShareMethod.clipboard,
        );
  }

  /// Fetches random gem IDs from the chest with the given [chestID].
  BobsJob<CRandomGemIDsFetchException, List<String>> fetchRandomGemIDs({
    required String chestID,
  }) =>
      gemClient
          .fetchRandomGemIDs(chestID: chestID, limit: 20)
          .thenConvertFailure(CRandomGemIDsFetchException.fromRaw);

  /// Fetches the gem associated with the given [shareToken].
  BobsJob<CGemFetchFromShareTokenException, CSharedGem> fetchGemFromShareToken({
    required String shareToken,
  }) =>
      gemClient.fetchGemFromShareToken(shareToken: shareToken).thenConvert(
            onFailure: CGemFetchFromShareTokenException.fromRaw,
            onSuccess: (result) => CSharedGem.fromRecords(result.$1, result.$2),
          );

  /// Creates a share token for the a gem.
  BobsJob<CGemShareTokenCreationException, String> createGemShareToken({
    required String chestID,
    required String gemID,
  }) =>
      gemClient
          .createGemShareToken(
            record: CGemShareTokensTableInsert(
              chestID: chestID,
              gemID: gemID,
            ),
          )
          .thenConvert(
            onFailure: CGemShareTokenCreationException.fromRaw,
            onSuccess: (success) => success.token,
          );
}
