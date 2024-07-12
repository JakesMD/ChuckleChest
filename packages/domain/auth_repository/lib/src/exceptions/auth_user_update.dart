import 'package:cauth_client/cauth_client.dart';
import 'package:cpub/meta.dart';

/// A exception thrown when a user update fails.
enum CAuthUserUpdateException {
  /// Indicates the cause in unknown.
  unknown;

  /// Converts the raw exception to a [CAuthUserUpdateException].
  @internal
  static CAuthUserUpdateException fromRaw(
    CRawAuthUserUpdateException exception,
  ) =>
      switch (exception) {
        CRawAuthUserUpdateException.unknown => CAuthUserUpdateException.unknown,
      };
}
