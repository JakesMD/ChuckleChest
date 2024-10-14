import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when fetching user invitations data
/// fails.
enum CRawUserInvitationsFetchException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawUserInvitationsFetchException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawUserInvitationsFetchException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawUserInvitationsFetchException',
      );
    }
    return CRawUserInvitationsFetchException.unknown;
  }
}
