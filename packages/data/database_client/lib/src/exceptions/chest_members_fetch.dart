// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when fetch chest member data fails.
enum CRawChestMembersFetchException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawChestMembersFetchException.fromError(Object error) {
    return CRawChestMembersFetchException.unknown;
  }
}
