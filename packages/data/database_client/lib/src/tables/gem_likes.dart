import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'gem_likes.g.dart';

/// {@template CGemLikesTable}
///
/// Represents the `gem_likes` table in the Supabase database.
///
/// {@endtemplate}
@PgTableHere()
class CGemLikesTable extends SupabaseTable<CGemLikesTable> {
  /// {@macro CGemLikesTable}
  CGemLikesTable(super.client)
    : super(tableName: tableName, primaryKey: [gemID, userID]);

  /// The name of the table in the Supabase database.
  static const tableName = PgTableName<CGemLikesTable>('gem_likes');

  /// The ID of the chest the gem belongs to.
  static final chestID = PgStringColumn<CGemLikesTable>('chest_id');

  /// The ID of the gem.
  static final gemID = PgStringColumn<CGemLikesTable>('gem_id');

  /// The ID of the user who liked the gem.
  @PgColumnHasDefault()
  static final userID = PgStringColumn<CGemLikesTable>('user_id');

  /// The time the gem was liked.
  @PgColumnHasDefault()
  static final likedAt = PgUTCDateTimeColumn<CGemLikesTable>('liked_at');
}
