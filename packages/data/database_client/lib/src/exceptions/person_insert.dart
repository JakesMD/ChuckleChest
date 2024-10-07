import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when inserting a person fails.
enum CRawPersonInsertException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawPersonInsertException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawPersonInsertException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawPersonInsertException',
      );
    }
    return CRawPersonInsertException.unknown;
  }
}
