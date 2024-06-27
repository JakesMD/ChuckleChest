import 'package:cauth_client/cauth_client.dart';
import 'package:cpub/meta.dart';

/// A exception thrown when a login fails.
enum CLoginException {
  /// Indicates the account does not exist.
  userNotFound,

  /// Indicates the email rate limited has been exceeded.
  emailRateLimitExceeded,

  /// Indicates the cause in unknown.
  unknown;

  /// Converts the raw exception to a [CLoginException].
  @internal
  static CLoginException fromRaw(CRawLoginException exception) =>
      switch (exception) {
        CRawLoginException.userNotFound => CLoginException.userNotFound,
        CRawLoginException.emailRateLimitExceeded =>
          CLoginException.emailRateLimitExceeded,
        CRawLoginException.unknown => CLoginException.unknown,
      };
}
