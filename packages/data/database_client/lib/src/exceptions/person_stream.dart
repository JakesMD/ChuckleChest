// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when streaming a person fails.
enum CRawPersonStreamException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawPersonStreamException.fromError(Object error) {
    return CRawPersonStreamException.unknown;
  }
}
