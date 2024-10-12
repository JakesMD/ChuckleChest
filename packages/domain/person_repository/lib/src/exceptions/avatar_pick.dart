import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cplatform_client/cplatform_client.dart';

/// Represents an exception that occurs when picking an avatar from the user's
/// gallery fails.
enum CAvatarPickException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CAvatarPickException].
  static CAvatarPickException fromRaw(Object e) {
    if (e is CRawAvatarUpsertException) {
      return switch (e) {
        CRawAvatarUpsertException.unknown => CAvatarPickException.unknown,
      };
    } else if (e is CImagePickException) {
      return switch (e) {
        CImagePickException.unknown => CAvatarPickException.unknown,
      };
    }
    return CAvatarPickException.unknown;
  }
}
