import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when fetching random gem IDs fails.
enum CRandomGemIDsFetchException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CRandomGemIDsFetchException].
  static CRandomGemIDsFetchException fromRaw(CRawRandomGemIDsFetchException e) {
    return switch (e) {
      CRawRandomGemIDsFetchException.unknown =>
        CRandomGemIDsFetchException.unknown,
    };
  }
}
