import 'dart:developer';

/// Represents an exception that occurs when a session refresh fails.
enum CRawSessionRefreshException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawSessionRefreshException.fromError(Object e) {
    log(e.toString(), error: e, name: 'CRawSessionRefreshException');
    return CRawSessionRefreshException.unknown;
  }
}
