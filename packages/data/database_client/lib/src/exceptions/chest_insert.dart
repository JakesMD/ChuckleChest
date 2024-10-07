import 'dart:developer';

/// Represents an exception that occurs when creating chest fails.
enum CRawChestInsertException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawChestInsertException.fromError(Object e, StackTrace s) {
    log(
      e.toString(),
      error: e,
      stackTrace: s,
      name: 'CRawChestInsertException',
    );
    return CRawChestInsertException.unknown;
  }
}
