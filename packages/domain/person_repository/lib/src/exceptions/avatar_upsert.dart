import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when upserting an avatar fails.
enum CAvatarUpsertException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CAvatarUpsertException].
  static CAvatarUpsertException fromRaw(CRawAvatarUpsertException e) {
    return switch (e) {
      CRawAvatarUpsertException.unknown => CAvatarUpsertException.unknown,
    };
  }
}
