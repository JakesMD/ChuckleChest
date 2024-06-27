import 'package:cauth_client/cauth_client.dart';
import 'package:cpub/meta.dart';

/// An exception thrown when refreshing a session fails.
enum CSessionRefreshException {
  /// Indicates the cause in unknown.
  unknown;

  /// Converts the raw exception to a [CSessionRefreshException].
  @internal
  static CSessionRefreshException fromRaw(
    CRawSessionRefreshException exception,
  ) =>
      switch (exception) {
        CRawSessionRefreshException.unknown => CSessionRefreshException.unknown
      };
}
