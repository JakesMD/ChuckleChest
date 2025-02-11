// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when fetching gem ID data fails.
enum CRawGemIDsFetchException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawGemIDsFetchException.fromError(Object error) {
    return CRawGemIDsFetchException.unknown;
  }
}
