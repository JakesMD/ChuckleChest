import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when fetching chest people fails.
enum CChestPeopleFetchException {
  /// The gem was not found.
  chestNotFound,

  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CChestPeopleFetchException].
  static CChestPeopleFetchException fromRaw(CRawChestPeopleFetchException e) {
    return switch (e) {
      CRawChestPeopleFetchException.chestNotFound =>
        CChestPeopleFetchException.chestNotFound,
      CRawChestPeopleFetchException.unknown =>
        CChestPeopleFetchException.unknown,
    };
  }
}
