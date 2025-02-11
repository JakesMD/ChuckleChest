// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when fetching random gem ID data fails.
enum CRawRandomGemIDsFetchException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawRandomGemIDsFetchException.fromError(Object error) {
    return CRawRandomGemIDsFetchException.unknown;
  }
}
