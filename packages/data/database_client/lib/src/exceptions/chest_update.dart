// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when updating a chest fails.
enum CRawChestUpdateException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawChestUpdateException.fromError(Object error) {
    return CRawChestUpdateException.unknown;
  }
}
