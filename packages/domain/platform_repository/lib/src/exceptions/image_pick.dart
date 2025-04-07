import 'package:cplatform_client/cplatform_client.dart' as bplatorm_client;

/// Represents an exception that can occur when picking an image.
enum CImagePickException {
  /// Indicates the cause in unknown.
  unknown;

  /// Creates the exception from the given error.
  static CImagePickException fromError(Object e) => CImagePickException.unknown;

  /// Creates the exception from the given failure.
  static CImagePickException fromFailure(
    bplatorm_client.CImagePickException e,
  ) =>
      switch (e) {
        bplatorm_client.CImagePickException.unknown =>
          CImagePickException.unknown,
      };
}
