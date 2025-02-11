import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when fetching gem data fails.
enum CRawGemFetchException {
  /// A gem with the provided ID was not found.
  notFound,

  /// The failure was unitentifiable.
  unknown;

  factory CRawGemFetchException.fromError(Object error) {
    if (error is PostgrestException &&
        (error.code == 'PGRST116' || error.code == '22P02')) {
      return CRawGemFetchException.notFound;
    }

    return CRawGemFetchException.unknown;
  }
}
