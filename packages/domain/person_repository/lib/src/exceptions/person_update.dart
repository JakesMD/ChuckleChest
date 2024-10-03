import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when updating a person fails.
enum CPersonUpdateException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CPersonUpdateException].
  static CPersonUpdateException fromRaw(CRawPersonUpdateException e) {
    return switch (e) {
      CRawPersonUpdateException.unknown => CPersonUpdateException.unknown,
    };
  }
}
