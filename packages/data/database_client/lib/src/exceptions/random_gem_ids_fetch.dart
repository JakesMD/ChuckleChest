import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when fetching random gem ID data fails.
enum CRawRandomGemIDsFetchException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawRandomGemIDsFetchException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawRandomGemIDsFetchException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawRandomGemIDsFetchException',
      );
    }
    return CRawRandomGemIDsFetchException.unknown;
  }
}
