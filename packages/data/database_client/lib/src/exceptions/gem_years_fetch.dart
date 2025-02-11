// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when fetching gem years data fails.
enum CRawGemYearsFetchException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawGemYearsFetchException.fromError(Object error) {
    return CRawGemYearsFetchException.unknown;
  }
}
