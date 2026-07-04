// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when deleting a gem like fails.
enum CRawGemLikeDeleteException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawGemLikeDeleteException.fromError(Object error) {
    return CRawGemLikeDeleteException.unknown;
  }
}
