import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when creating an invitation fails.
enum CRawInvitationCreationException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawInvitationCreationException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawInvitationCreationException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawInvitationCreationException',
      );
    }
    return CRawInvitationCreationException.unknown;
  }
}
