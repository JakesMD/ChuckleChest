import 'dart:developer';

/// Represents an exception that occurs when copying data to the clipboard.
enum CClipboardCopyException {
  /// The failure was unitentifiable.
  unknown;

  factory CClipboardCopyException.fromError(Object e, StackTrace s) {
    log(e.toString(), error: e, stackTrace: s, name: 'CClipboardCopyException');
    return CClipboardCopyException.unknown;
  }
}
