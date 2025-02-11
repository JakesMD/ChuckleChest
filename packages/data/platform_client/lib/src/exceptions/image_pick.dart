// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when picking an image from the user's
/// gallery.
enum CImagePickException {
  /// The failure was unitentifiable.
  unknown;

  factory CImagePickException.fromError(Object error) {
    return CImagePickException.unknown;
  }
}
