import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when fetching gems from a share token
/// fails.
enum CRawGemFetchFromShareTokenException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawGemFetchFromShareTokenException.fromError(
    Object e,
    StackTrace s,
  ) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawGemFetchFromShareTokenException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawGemFetchFromShareTokenException',
      );
    }
    return CRawGemFetchFromShareTokenException.unknown;
  }
}
