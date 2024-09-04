import 'dart:developer';

/// Represents an exception that occurs when a session refresh fails.
enum CRawSessionRefreshException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawSessionRefreshException.fromError(Object e, StackTrace s) {
    log(
      e.toString(),
      error: e,
      stackTrace: s,
      name: 'CRawSessionRefreshException',
    );
    return CRawSessionRefreshException.unknown;
  }
}
