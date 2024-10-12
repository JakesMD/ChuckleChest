import 'dart:developer';

/// Represents an exception that occurs when picking an image from the user's
/// gallery.
enum CImagePickException {
  /// The failure was unitentifiable.
  unknown;

  factory CImagePickException.fromError(Object e, StackTrace s) {
    log(e.toString(), error: e, stackTrace: s, name: 'CImagePickException');
    return CImagePickException.unknown;
  }
}
