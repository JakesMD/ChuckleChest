import 'package:supabase/supabase.dart';

/// Represents an exception that occurs when fetching chest people fails.
enum CRawChestPeopleFetchException {
  /// A chest with the provided ID was not found.
  chestNotFound,

  /// The failure was unitentifiable.
  unknown;

  factory CRawChestPeopleFetchException.fromError(Object error) {
    if (error is PostgrestException &&
        (error.code == 'PGRST116' || error.code == '22P02')) {
      return CRawChestPeopleFetchException.chestNotFound;
    }

    return CRawChestPeopleFetchException.unknown;
  }
}
