import 'package:cauth_client/cauth_client.dart';
import 'package:meta/meta.dart';

/// A exception thrown when a signup fails.
enum CSignupException {
  /// Indicates the email rate limited has been exceeded.
  emailRateLimitExceeded,

  /// Indicates the cause in unknown.
  unknown;

  /// Converts the raw exception to a [CSignupException].
  @internal
  static CSignupException fromRaw(CRawSignupException exception) =>
      switch (exception) {
        CRawSignupException.emailRateLimitExceeded =>
          CSignupException.emailRateLimitExceeded,
        CRawSignupException.unknown => CSignupException.unknown,
      };
}
