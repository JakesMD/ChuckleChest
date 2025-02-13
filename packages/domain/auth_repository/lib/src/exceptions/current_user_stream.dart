import 'package:cauth_client/cauth_client.dart';
import 'package:meta/meta.dart';

/// A exception thrown when streaming the current user fails.
enum CCurrentUserStreamException {
  /// Indicates the cause in unknown.
  unknown;

  /// Converts the raw exception to a [CCurrentUserStreamException].
  @internal
  static CCurrentUserStreamException fromRaw(
    CRawCurrentUserStreamException exception,
  ) =>
      switch (exception) {
        CRawCurrentUserStreamException.unknown =>
          CCurrentUserStreamException.unknown,
      };
}
