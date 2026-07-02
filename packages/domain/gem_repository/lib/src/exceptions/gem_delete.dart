import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when deleting a gem fails.
enum CGemDeleteException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CGemDeleteException].
  static CGemDeleteException fromRaw(CRawGemDeleteException e) {
    return switch (e) {
      CRawGemDeleteException.unknown => CGemDeleteException.unknown,
    };
  }
}
