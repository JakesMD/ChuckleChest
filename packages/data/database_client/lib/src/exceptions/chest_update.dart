import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when updating a chest fails.
enum CRawChestUpdateException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawChestUpdateException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawChestUpdateException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawChestUpdateException',
      );
    }
    return CRawChestUpdateException.unknown;
  }
}
