import 'dart:developer';

/// Represents an exception that occurs when sharing content using the device's
/// platform.
enum CShareException {
  /// The failure was unitentifiable.
  unknown;

  factory CShareException.fromError(Object e) {
    log(e.toString(), error: e, name: 'CShareException');
    return CShareException.unknown;
  }
}
