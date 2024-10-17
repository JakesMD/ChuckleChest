import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when updating a member's role fails.
enum CRawMemberRoleUpdateException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawMemberRoleUpdateException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawMemberRoleUpdateException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawMemberRoleUpdateException',
      );
    }
    return CRawMemberRoleUpdateException.unknown;
  }
}
