import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when fetching gem years data fails.
enum CRawGemYearsFetchException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawGemYearsFetchException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawGemYearsFetchException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawGemYearsFetchException',
      );
    }
    return CRawGemYearsFetchException.unknown;
  }
}
