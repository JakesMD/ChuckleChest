// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when fetch chest invitation data fails.
enum CRawChestInvitationsFetchException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawChestInvitationsFetchException.fromError(Object error) {
    return CRawChestInvitationsFetchException.unknown;
  }
}
