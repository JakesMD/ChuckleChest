// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when fetching gems from a share token
/// fails.
enum CRawGemFetchFromShareTokenException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawGemFetchFromShareTokenException.fromError(Object error) {
    return CRawGemFetchFromShareTokenException.unknown;
  }
}
