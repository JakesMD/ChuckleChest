import 'package:ccore/ccore.dart';
import 'package:cgem_client/cgem_client.dart';
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
  CJob<CRawGemFetchException, CRawGem> fetchGem({
    required String gemID,
    required bool withAvatarURLs,
  }) =>
      CJob.attempt(
        run: () async {
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

          return CRawGem.fromJSON(result);
        },
        onError: CRawGemFetchException.fromError,
      );
}
