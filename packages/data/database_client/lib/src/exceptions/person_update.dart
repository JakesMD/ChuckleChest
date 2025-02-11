// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when updating a person fails.
enum CRawPersonUpdateException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawPersonUpdateException.fromError(Object error) {
    return CRawPersonUpdateException.unknown;
  }
}
