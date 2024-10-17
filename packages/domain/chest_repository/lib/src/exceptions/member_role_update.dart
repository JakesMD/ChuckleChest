import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when updating a member's role fails.
enum CMemberRoleUpdateException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CMemberRoleUpdateException].
  static CMemberRoleUpdateException fromRaw(CRawMemberRoleUpdateException e) {
    return switch (e) {
      CRawMemberRoleUpdateException.unknown =>
        CMemberRoleUpdateException.unknown,
    };
  }
}
