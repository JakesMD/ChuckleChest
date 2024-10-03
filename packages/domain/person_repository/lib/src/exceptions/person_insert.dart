import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when inserting a person fails.
enum CPersonInsertException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CPersonInsertException].
  static CPersonInsertException fromRaw(CRawPersonInsertException e) {
    return switch (e) {
      CRawPersonInsertException.unknown => CPersonInsertException.unknown,
    };
  }
}
