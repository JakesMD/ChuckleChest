// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when uploading an avatar fails.
enum CRawAvatarUploadException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawAvatarUploadException.fromError(Object error) {
    return CRawAvatarUploadException.unknown;
  }
}
