import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when fetching chest people fails.
enum CRawChestPeopleFetchException {
  /// A chest with the provided ID was not found.
  chestNotFound,

  /// The failure was unitentifiable.
  unknown;

  factory CRawChestPeopleFetchException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawChestPeopleFetchException',
      );
      if (e.code == 'PGRST116' || e.code == '22P02') {
        return CRawChestPeopleFetchException.chestNotFound;
      }
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawChestPeopleFetchException',
      );
    }
    return CRawChestPeopleFetchException.unknown;
  }
}
