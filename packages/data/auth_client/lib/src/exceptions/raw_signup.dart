import 'dart:developer';

import 'package:cpub/supabase.dart';

/// An exception thrown when a sign-up fails.
enum CRawSignupException {
  /// Indicates the email rate limited has been exceeded.
  emailRateLimitExceeded,

  /// Indicates the cause in unknown.
  unknown;

  /// Converts an error into a [CRawSignupException].
  static CRawSignupException fromError(Object error) {
    if (error is AuthException) {
      log(error.message, error: error, name: 'CRawSignupException');
      if (error.statusCode == '429') {
        return CRawSignupException.emailRateLimitExceeded;
      }
    }
    log(error.toString(), error: error, name: 'CRawSignupException');
    return CRawSignupException.unknown;
  }
}