import 'package:cauth_client/cauth_client.dart';
import 'package:cpub/meta.dart';

/// An exception thrown when an OTP verification fails.
enum COTPVerificationException {
  /// Indicates that the provided OTP token is not valid.
  invalidToken,

  /// Indicates the cause in unknown.
  unknown;

  /// Converts the raw exception to a [COTPVerificationException].
  @internal
  static COTPVerificationException fromRaw(
    CRawOTPVerificationException exception,
  ) =>
      switch (exception) {
        CRawOTPVerificationException.invalidToken =>
          COTPVerificationException.invalidToken,
        CRawOTPVerificationException.unknown =>
          COTPVerificationException.unknown,
      };
}
