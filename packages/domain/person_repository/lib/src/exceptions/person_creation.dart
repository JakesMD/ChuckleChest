import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when inserting a person fails.
enum CPersonCreationException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CPersonCreationException].
  static CPersonCreationException fromRaw(CRawPersonInsertException e) {
    return switch (e) {
      CRawPersonInsertException.unknown => CPersonCreationException.unknown,
    };
  }
}
