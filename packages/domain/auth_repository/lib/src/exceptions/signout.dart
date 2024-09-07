import 'package:cauth_client/cauth_client.dart';
import 'package:meta/meta.dart';

/// An exception thrown when a sign-out fails.
enum CSignoutException {
  /// Indicates the cause in unknown.
  unknown;

  /// Converts the raw exception to a [CSignoutException].
  @internal
  static CSignoutException fromRaw(CRawSignoutException exception) =>
      switch (exception) {
        CRawSignoutException.unknown => CSignoutException.unknown,
      };
}
