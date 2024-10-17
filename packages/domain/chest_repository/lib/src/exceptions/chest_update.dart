import 'package:cdatabase_client/cdatabase_client.dart';

/// Represents an exception that occurs when updating a chest fails.
enum CChestUpdateException {
  /// The failure was unitentifiable.
  unknown;

  /// Converts the raw exception to a [CChestUpdateException].
  static CChestUpdateException fromRaw(CRawChestUpdateException e) {
    return switch (e) {
      CRawChestUpdateException.unknown => CChestUpdateException.unknown,
    };
  }
}
