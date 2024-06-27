import 'dart:developer';

/// Represents an exception that occurs when updating a user fails.
enum CRawAuthUserUpdateException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawAuthUserUpdateException.fromError(Object e) {
    log(e.toString(), error: e, name: 'CRawAuthUserUpdateException');
    return CRawAuthUserUpdateException.unknown;
  }
}
