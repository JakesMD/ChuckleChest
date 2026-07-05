import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when unliking a gem fails.
enum CGemLikeDeleteException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CGemLikeDeleteException].
  static CGemLikeDeleteException fromRaw(CRawGemLikeDeleteException e) {
    return switch (e) {
      CRawGemLikeDeleteException.unknown => CGemLikeDeleteException.unknown,
    };
  }
}
