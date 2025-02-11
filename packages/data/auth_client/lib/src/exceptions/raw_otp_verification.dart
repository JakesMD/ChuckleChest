import 'package:supabase/supabase.dart';

/// An exception thrown when an OTP verification fails.
enum CRawOTPVerificationException {
  /// Indicates that the provided OTP token is not valid.
  invalidToken,

  /// Indicates the cause in unknown.
  unknown;

  factory CRawOTPVerificationException.fromError(Object error) {
    if (error is AuthException && error.statusCode == '403') {
      return CRawOTPVerificationException.invalidToken;
    }

    return CRawOTPVerificationException.unknown;
  }
}
