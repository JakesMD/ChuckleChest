import 'dart:developer';

/// Represents an exception that occurs when creating chest fails.
enum CRawChestCreationException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawChestCreationException.fromError(Object e, StackTrace s) {
    log(
      e.toString(),
      error: e,
      stackTrace: s,
      name: 'CRawChestCreationException',
    );
    return CRawChestCreationException.unknown;
  }
}
