import 'dart:developer';

/// Represents an exception that occurs when copying data to the clipboard.
enum CClipboardCopyException {
  /// The failure was unitentifiable.
  unknown;

  factory CClipboardCopyException.fromError(Object e) {
    log(e.toString(), error: e, name: 'CClipboardCopyException');
    return CClipboardCopyException.unknown;
  }
}
