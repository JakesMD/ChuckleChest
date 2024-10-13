import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when user invitations fetch fails.
enum CInvitationAcceptException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CInvitationAcceptException].
  static CInvitationAcceptException fromRaw(CRawInvitationAcceptException e) {
    return switch (e) {
      CRawInvitationAcceptException.unknown =>
        CInvitationAcceptException.unknown,
    };
  }
}
