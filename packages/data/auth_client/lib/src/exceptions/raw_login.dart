import 'package:supabase/supabase.dart';

/// An exception thrown when a login fails.
enum CRawLoginException {
  /// Indicates the account does not exist.
  userNotFound,

  /// Indicates the email rate limited has been exceeded.
  emailRateLimitExceeded,

  /// Indicates the cause in unknown.
  unknown;

  /// Converts an error into a [CRawLoginException].
  static CRawLoginException fromError(Object error) {
    if (error is AuthException) {
      if (error.statusCode == '422') return CRawLoginException.userNotFound;
      if (error.statusCode == '429') {
        return CRawLoginException.emailRateLimitExceeded;
      }
    }

    return CRawLoginException.unknown;
  }
}
