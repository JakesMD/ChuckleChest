import 'dart:developer';

/// Represents an exception that occurs when signing out fails.
enum CRawSignoutException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawSignoutException.fromError(Object e, StackTrace s) {
    log(
      e.toString(),
      error: e,
      stackTrace: s,
      name: 'CRawSignoutException',
    );
    return CRawSignoutException.unknown;
  }
}
