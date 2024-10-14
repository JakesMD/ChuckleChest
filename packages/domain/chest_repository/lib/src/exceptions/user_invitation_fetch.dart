import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when user invitations fetch fails.
enum CUserInvitationsFetchException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CUserInvitationsFetchException].
  static CUserInvitationsFetchException fromRaw(
    CRawUserInvitationsFetchException e,
  ) {
    return switch (e) {
      CRawUserInvitationsFetchException.unknown =>
        CUserInvitationsFetchException.unknown,
    };
  }
}
