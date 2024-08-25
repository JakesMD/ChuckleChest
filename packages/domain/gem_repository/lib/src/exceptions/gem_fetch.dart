import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when fetching a gem fails.
enum CGemFetchException {
  /// The gem was not found.
  notFound,

  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CGemFetchException].
  static CGemFetchException fromRaw(CRawGemFetchException e) {
    return switch (e) {
      CRawGemFetchException.notFound => CGemFetchException.notFound,
      CRawGemFetchException.unknown => CGemFetchException.unknown,
    };
  }
}
