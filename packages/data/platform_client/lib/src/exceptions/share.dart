// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when sharing content using the device's
/// platform.
enum CShareException {
  /// The failure was unitentifiable.
  unknown;

  factory CShareException.fromError(Object error) {
    return CShareException.unknown;
  }
}
