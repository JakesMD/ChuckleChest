import 'dart:developer';

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
  static CRawLoginException fromError(Object error, StackTrace s) {
    if (error is AuthException) {
      log(
        error.message,
        error: error,
        stackTrace: s,
        name: 'CRawLoginException',
      );
      if (error.statusCode == '422') {
        return CRawLoginException.userNotFound;
      }
      if (error.statusCode == '429') {
        return CRawLoginException.emailRateLimitExceeded;
      }
    }
    log(
      error.toString(),
      error: error,
      stackTrace: s,
      name: 'CRawLoginException.fromError',
    );
    return CRawLoginException.unknown;
  }
}
