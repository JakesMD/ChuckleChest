// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when saving gem data fails.
enum CRawGemSaveException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawGemSaveException.fromError(Object error) {
    return CRawGemSaveException.unknown;
  }
}
