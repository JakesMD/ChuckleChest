// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when updating a user fails.
enum CRawAuthUserUpdateException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawAuthUserUpdateException.fromError(Object error) {
    return CRawAuthUserUpdateException.unknown;
  }
}
