// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when inserting a gem share token fails.
enum CRawGemShareTokenInsertException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawGemShareTokenInsertException.fromError(Object error) {
    return CRawGemShareTokenInsertException.unknown;
  }
}
