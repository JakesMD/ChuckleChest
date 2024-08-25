import 'dart:developer';

import 'package:cpub/supabase.dart';

/// Represents an exception that occurs when creating chest fails.
enum CRawChestCreationException {
  /// The failure was unitentifiable.
  unknown;

  factory CRawChestCreationException.fromError(Object e) {
    if (e is PostgrestException) {
      log(e.message, error: e, name: 'CRawChestCreationException');
    } else {
      log(e.toString(), error: e, name: 'CRawChestCreationException');
    }
    return CRawChestCreationException.unknown;
  }
}
