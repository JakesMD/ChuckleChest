import 'dart:developer';

import 'package:cpub/supabase.dart';

/// Represents an exception that occurs when fetching gem data fails.
enum CRawGemFetchException {
  /// A gem with the provided ID was not found.
  notFound,

  /// The failure was unitentifiable.
  unknown;

  factory CRawGemFetchException.fromError(Object e) {
    if (e is PostgrestException) {
      log(e.message, error: e, name: 'CRawGemFetchException');
      if (e.code == 'PGRST116' || e.code == '22P02') {
        return CRawGemFetchException.notFound;
      }
    } else {
      log(e.toString(), error: e, name: 'CRawGemFetchException');
    }
    return CRawGemFetchException.unknown;
  }
}
