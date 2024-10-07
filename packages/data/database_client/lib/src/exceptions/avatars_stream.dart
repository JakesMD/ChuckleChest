import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when streaming avatars fails.
enum CRawAvatarsStreamException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawAvatarsStreamException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawAvatarsStreamException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawAvatarsStreamException',
      );
    }
    return CRawAvatarsStreamException.unknown;
  }
}
