import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cplatform_client/cplatform_client.dart';

/// Represents an exception that occurs when upserting an avatar fails.
enum CAvatarUpdateException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the error to a [CAvatarUpdateException].
  static CAvatarUpdateException fromError(Object error) {
    return CAvatarUpdateException.unknown;
  }

  /// Converts the raw exception to a [CAvatarUpdateException].
  static CAvatarUpdateException fromRaw(Object e) {
    if (e is CRawAvatarUpsertException) {
      return switch (e) {
        CRawAvatarUpsertException.unknown => CAvatarUpdateException.unknown,
      };
    } else if (e is CImagePickException) {
      return switch (e) {
        CImagePickException.unknown => CAvatarUpdateException.unknown,
      };
    }
    return CAvatarUpdateException.unknown;
  }
}
