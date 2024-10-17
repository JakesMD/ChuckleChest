import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when fetch chest member data fails.
enum CRawChestMembersFetchException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawChestMembersFetchException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawChestMembersFetchException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawChestMembersFetchException',
      );
    }
    return CRawChestMembersFetchException.unknown;
  }
}
