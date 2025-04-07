/// Represents an exception that can occur when picking an image.
enum CImagePickException {
  /// The cause for the exception is unknown.
  unknown;

  /// creates the exception from the given error.
  static CImagePickException fromError(Object e) => CImagePickException.unknown;
}
