// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when a session refresh fails.
enum CRawSessionRefreshException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawSessionRefreshException.fromError(Object error) {
    return CRawSessionRefreshException.unknown;
  }
}
