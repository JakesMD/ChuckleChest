// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when copying data to the clipboard.
enum CClipboardCopyException {
  /// The failure was unitentifiable.
  unknown;

  factory CClipboardCopyException.fromError(Object error) {
    return CClipboardCopyException.unknown;
  }
}
