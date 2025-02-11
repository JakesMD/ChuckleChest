// Parameters required for bobs jobs.
// ignore_for_file: avoid_unused_constructor_parameters

/// Represents an exception that occurs when upserting an avatar fails.
enum CRawAvatarUpsertException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawAvatarUpsertException.fromError(Object error) {
    return CRawAvatarUpsertException.unknown;
  }
}
