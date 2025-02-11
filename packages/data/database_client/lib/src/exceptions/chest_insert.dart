// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when creating chest fails.
enum CRawChestInsertException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawChestInsertException.fromError(Object error) {
    return CRawChestInsertException.unknown;
  }
}
