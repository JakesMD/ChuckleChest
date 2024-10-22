import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when fetching a gem from a share token.
enum CGemFetchFromShareTokenException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CGemFetchFromShareTokenException].
  static CGemFetchFromShareTokenException fromRaw(
    CRawGemFetchFromShareTokenException e,
  ) {
    return switch (e) {
      CRawGemFetchFromShareTokenException.unknown =>
        CGemFetchFromShareTokenException.unknown,
    };
  }
}
