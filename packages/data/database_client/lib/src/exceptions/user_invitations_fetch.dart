// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when fetching user invitations data
/// fails.
enum CRawInvitationsFetchException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawInvitationsFetchException.fromError(Object error) {
    return CRawInvitationsFetchException.unknown;
  }
}
