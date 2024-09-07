import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when saving a gem fails.
enum CGemSaveException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CGemSaveException].
  static CGemSaveException fromRaw(CRawGemSaveException e) {
    return switch (e) {
      CRawGemSaveException.unknown => CGemSaveException.unknown,
    };
  }
}
