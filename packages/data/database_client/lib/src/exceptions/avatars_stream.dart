// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when streaming avatars fails.
enum CRawAvatarsStreamException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawAvatarsStreamException.fromError(Object error) {
    return CRawAvatarsStreamException.unknown;
  }
}
