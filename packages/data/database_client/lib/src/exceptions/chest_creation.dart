import 'dart:developer';

/// Represents an exception that occurs when creating chest fails.
enum CRawChestCreationException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawChestCreationException.fromError(Object e) {
    log(e.toString(), error: e, name: 'CRawChestCreationException');
    return CRawChestCreationException.unknown;
  }
}
