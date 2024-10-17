import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when creating an invitation fails.
enum CInvitationCreationException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CInvitationCreationException].
  static CInvitationCreationException fromRaw(
    CRawInvitationCreationException e,
  ) {
    return switch (e) {
      CRawInvitationCreationException.unknown =>
        CInvitationCreationException.unknown,
    };
  }
}
