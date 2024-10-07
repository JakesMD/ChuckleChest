import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when upserting an avatar fails.
enum CRawAvatarUpsertException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawAvatarUpsertException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawAvatarUpsertException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawAvatarUpsertException',
      );
    }
    return CRawAvatarUpsertException.unknown;
  }
}
