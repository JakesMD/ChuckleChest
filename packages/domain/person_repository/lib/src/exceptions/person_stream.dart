import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when streaming a person fails.
enum CPersonStreamException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CPersonStreamException].
  static CPersonStreamException fromRaw(CRawPersonStreamException e) {
    return switch (e) {
      CRawPersonStreamException.unknown => CPersonStreamException.unknown,
    };
  }
}
