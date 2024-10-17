import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when fetching members fails.
enum CMembersFetchException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CMembersFetchException].
  static CMembersFetchException fromRaw(CRawChestMembersFetchException e) {
    return switch (e) {
      CRawChestMembersFetchException.unknown => CMembersFetchException.unknown,
    };
  }
}
