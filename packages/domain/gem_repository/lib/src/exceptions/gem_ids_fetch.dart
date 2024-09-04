import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when fetching gem IDs fails.
enum CGemIDsFetchException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CGemIDsFetchException].
  static CGemIDsFetchException fromRaw(CRawGemIDsFetchException e) {
    return switch (e) {
      CRawGemIDsFetchException.unknown => CGemIDsFetchException.unknown,
    };
  }
}
