import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when inserting a gem share token fails.
enum CRawGemShareTokenInsertException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawGemShareTokenInsertException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawGemShareTokenInsertException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawGemShareTokenInsertException',
      );
    }
    return CRawGemShareTokenInsertException.unknown;
  }
}
