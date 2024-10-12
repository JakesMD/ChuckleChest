import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when uploading an avatar fails.
enum CRawAvatarUploadException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawAvatarUploadException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawAvatarUploadException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawAvatarUploadException',
      );
    }
    return CRawAvatarUploadException.unknown;
  }
}
