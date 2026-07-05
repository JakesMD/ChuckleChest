import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when liking a gem fails.
enum CGemLikeInsertException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CGemLikeInsertException].
  static CGemLikeInsertException fromRaw(CRawGemLikeInsertException e) {
    return switch (e) {
      CRawGemLikeInsertException.unknown => CGemLikeInsertException.unknown,
    };
  }
}
