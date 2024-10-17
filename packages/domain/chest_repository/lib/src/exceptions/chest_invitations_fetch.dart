import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when fetching chest invitations fails.
enum CChestInvitationsFetchException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CChestInvitationsFetchException].
  static CChestInvitationsFetchException fromRaw(
    CRawChestInvitationsFetchException e,
  ) {
    return switch (e) {
      CRawChestInvitationsFetchException.unknown =>
        CChestInvitationsFetchException.unknown,
    };
  }
}
