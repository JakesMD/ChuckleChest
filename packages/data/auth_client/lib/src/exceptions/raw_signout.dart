// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when signing out fails.
enum CRawSignoutException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawSignoutException.fromError(Object error) {
    return CRawSignoutException.unknown;
  }
}
