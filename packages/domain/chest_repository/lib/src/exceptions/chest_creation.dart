import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when creating a chest fails.
enum CChestCreationException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CChestCreationException].
  static CChestCreationException fromRaw(CRawChestInsertException e) {
    return switch (e) {
      CRawChestInsertException.unknown => CChestCreationException.unknown,
    };
  }
}
