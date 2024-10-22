import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when creating a gem share token fails.
enum CGemShareTokenCreationException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CGemShareTokenCreationException].
  static CGemShareTokenCreationException fromRaw(
    CRawGemShareTokenInsertException e,
  ) {
    return switch (e) {
      CRawGemShareTokenInsertException.unknown =>
        CGemShareTokenCreationException.unknown,
    };
  }
}
