import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when fetching gem years fails.
enum CGemYearsFetchException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CGemYearsFetchException].
  static CGemYearsFetchException fromRaw(CRawGemYearsFetchException e) {
    return switch (e) {
      CRawGemYearsFetchException.unknown => CGemYearsFetchException.unknown,
    };
  }
}
