import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when fetching gem ID data fails.
enum CRawGemIDsFetchException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawGemIDsFetchException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawGemIDsFetchException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawGemIDsFetchException',
      );
    }
    return CRawGemIDsFetchException.unknown;
  }
}
