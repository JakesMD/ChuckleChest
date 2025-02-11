// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when inserting a person fails.
enum CRawPersonInsertException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawPersonInsertException.fromError(Object error) {
    return CRawPersonInsertException.unknown;
  }
}
