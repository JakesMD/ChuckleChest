import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when fetching gem data fails.
enum CRawGemFetchException {
  /// A gem with the provided ID was not found.
  notFound,

  /// The failure was unitentifiable.
  unknown;

  factory CRawGemFetchException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(e.message, error: e, stackTrace: s, name: 'CRawGemFetchException');
      if (e.code == 'PGRST116' || e.code == '22P02') {
        return CRawGemFetchException.notFound;
      }
    } else {
      log(e.toString(), error: e, stackTrace: s, name: 'CRawGemFetchException');
    }
    return CRawGemFetchException.unknown;
  }
}
