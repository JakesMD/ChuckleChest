// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when accepting an invitation fails.
enum CRawInvitationAcceptException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawInvitationAcceptException.fromError(Object error) {
    return CRawInvitationAcceptException.unknown;
  }
}
