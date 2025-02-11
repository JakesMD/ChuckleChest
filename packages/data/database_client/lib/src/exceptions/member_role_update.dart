// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when updating a member's role fails.
enum CRawMemberRoleUpdateException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawMemberRoleUpdateException.fromError(Object error) {
    return CRawMemberRoleUpdateException.unknown;
  }
}
