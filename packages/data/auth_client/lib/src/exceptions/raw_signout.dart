import 'dart:developer';

/// Represents an exception that occurs when signing out fails.
enum CRawSignoutException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawSignoutException.fromError(Object e) {
    log(e.toString(), error: e, name: 'CRawSignoutException');
    return CRawSignoutException.unknown;
  }
}
