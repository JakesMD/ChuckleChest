import 'dart:developer';

import 'package:cgem_client/cgem_client.dart';
import 'package:cpub/dartz.dart';
import 'package:cpub/supabase.dart';
import 'package:csupabase_client/csupabase_client.dart';

/// {@template CGemClient}
///
/// The client to interact with the gem API.
///
/// {@endtemplate}
class CGemClient {
  /// {@macro CGemClient}
  const CGemClient({required this.supabaseClient});

  /// The supabase client to interact with the database.
  final CSupabaseClient supabaseClient;

  /// Fetches the gem with the given [gemID] from the database.
  ///
  /// If [withAvatarURLs] is `true`, the gem will include the avatar URLs.
  Future<Either<CRawGemFetchException, CRawGem>> fetchGem({
    required String gemID,
    required bool withAvatarURLs,
  }) async {
    try {
      final result = await supabaseClient.fetchSingle(
        table: 'gems',
        eqColumn: 'id',
        eqValue: gemID,
        columns: '''
          *,
          lines(
            *,
            connections(
              *${withAvatarURLs ? ', connection_avatar_urls(*)' : ''}
            )
          )
        ''',
      );

      return right(CRawGem.fromJSON(result));
    } on PostgrestException catch (e, s) {
      if (e.code == 'PGRST116' || e.code == '22P02') {
        return left(CRawGemFetchException.notFound);
      }
      log(e.message, stackTrace: s, error: e, name: 'CGemClient.fetchGem');
    } catch (e, s) {
      log(e.toString(), stackTrace: s, error: e, name: 'CGemClient.fetchGem');
    }
    return left(CRawGemFetchException.unknown);
  }
}
