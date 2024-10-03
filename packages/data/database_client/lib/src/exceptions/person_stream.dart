import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when streaming a person fails.
enum CRawPersonStreamException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawPersonStreamException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawPersonStreamException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawPersonStreamException',
      );
    }
    return CRawPersonStreamException.unknown;
  }
}
