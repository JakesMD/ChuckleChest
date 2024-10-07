import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when updating a person fails.
enum CRawPersonUpdateException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawPersonUpdateException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawPersonUpdateException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawPersonUpdateException',
      );
    }
    return CRawPersonUpdateException.unknown;
  }
}
