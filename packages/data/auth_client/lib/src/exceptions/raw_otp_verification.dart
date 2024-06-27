import 'dart:developer';

import 'package:cpub/supabase.dart';

/// An exception thrown when an OTP verification fails.
enum CRawOTPVerificationException {
  /// Indicates that the provided OTP token is not valid.
  invalidToken,

  /// Indicates the cause in unknown.
  unknown;

  factory CRawOTPVerificationException.fromError(Object e) {
    if (e is AuthException) {
      if (e.statusCode == '403') {
        log(e.message, error: e, name: 'CAuthClient.verifyOTP');
        return CRawOTPVerificationException.invalidToken;
      }
    }
    log(e.toString(), error: e, name: 'CRawOTPVerificationException');
    return CRawOTPVerificationException.unknown;
  }
}
