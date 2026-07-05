// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when inserting a gem like fails.
enum CRawGemLikeInsertException {
  /// The failure was unidentifiable.
  unknown;

  factory CRawGemLikeInsertException.fromError(Object error) {
    return CRawGemLikeInsertException.unknown;
  }
}
