import 'package:cplatform_client/cplatform_client.dart';

/// Represents an exception that occurs when sharing a gem fails.
enum CGemShareException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CGemShareException].
  static CGemShareException fromRaw(dynamic e) {
    if (e is CShareException) {
      return switch (e) {
        CShareException.unknown => CGemShareException.unknown,
      };
    }
    if (e is CClipboardCopyException) {
      return switch (e) {
        CClipboardCopyException.unknown => CGemShareException.unknown,
      };
    }
    return CGemShareException.unknown;
  }
}
