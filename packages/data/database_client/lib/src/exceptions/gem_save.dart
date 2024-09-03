import 'dart:developer';

import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when saving gem data fails.
enum CRawGemSaveException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawGemSaveException.fromError(Object e, StackTrace s) {
    if (e is PostgrestException) {
      log(
        e.message,
        error: e,
        stackTrace: s,
        name: 'CRawGemSaveException',
      );
    } else {
      log(
        e.toString(),
        error: e,
        stackTrace: s,
        name: 'CRawGemSaveException',
      );
    }
    return CRawGemSaveException.unknown;
  }
}
