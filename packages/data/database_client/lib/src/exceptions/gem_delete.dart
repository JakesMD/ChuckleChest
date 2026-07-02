// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when deleting gem data fails.
enum CRawGemDeleteException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawGemDeleteException.fromError(Object error) {
    return CRawGemDeleteException.unknown;
  }
}
