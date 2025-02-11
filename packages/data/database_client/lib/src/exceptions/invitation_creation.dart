// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when creating an invitation fails.
enum CRawInvitationCreationException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawInvitationCreationException.fromError(Object error) {
    return CRawInvitationCreationException.unknown;
  }
}
