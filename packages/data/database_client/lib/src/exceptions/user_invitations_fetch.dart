// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when fetching user invitations data
/// fails.
enum CRawUserInvitationsFetchException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawUserInvitationsFetchException.fromError(Object error) {
    return CRawUserInvitationsFetchException.unknown;
  }
}
