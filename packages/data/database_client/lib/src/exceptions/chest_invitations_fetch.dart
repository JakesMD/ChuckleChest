import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when fetch chest invitation data fails.
enum CRawChestInvitationsFetchException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawChestInvitationsFetchException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawChestInvitationsFetchException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawChestInvitationsFetchException',
      );
    }
    return CRawChestInvitationsFetchException.unknown;
  }
}
