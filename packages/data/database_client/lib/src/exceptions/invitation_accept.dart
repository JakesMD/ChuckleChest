import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when accepting an invitation fails.
enum CRawInvitationAcceptException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawInvitationAcceptException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawInvitationAcceptException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawInvitationAcceptException',
      );
    }
    return CRawInvitationAcceptException.unknown;
  }
}
