import 'dart:developer';

/// Represents an exception that occurs when sharing content using the device's
/// platform.
enum CShareException {
  /// The failure was unitentifiable.
  unknown;

  factory CShareException.fromError(Object e, StackTrace s) {
    log(e.toString(), error: e, stackTrace: s, name: 'CShareException');
    return CShareException.unknown;
  }
}
