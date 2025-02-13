// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when streaming the current user fails.
enum CRawCurrentUserStreamException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawCurrentUserStreamException.fromError(Object error) {
    return CRawCurrentUserStreamException.unknown;
  }
}
