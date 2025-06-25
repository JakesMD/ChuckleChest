import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'gems.g.dart';

/// {@template CGemsTable}
///
/// Represents the `gems` table in the Supabase database.
///
/// {@endtemplate}
@PgTableHere()
class CGemsTable extends SupabaseTable<CGemsTable> {
  /// {@macro CGemsTable}
  CGemsTable(super.client) : super(tableName: tableName, primaryKey: [id]);

  /// The name of the table in the Supabase database.
  static const tableName = PgTableName<CGemsTable>('gems');

  /// The unique identifier of the gem.
  @PgColumnHasDefault()
  static final id = PgStringColumn<CGemsTable>('id');

  /// The number of the gem.
  @PgColumnHasDefault()
  static final number = PgIntColumn<CGemsTable>('number');

  /// The date and time when the story occurred.
  static final occurredAt = PgUTCDateTimeColumn<CGemsTable>('occurred_at');

  /// The time the gem was created.
  @PgColumnHasDefault()
  static final createdAt = PgUTCDateTimeColumn<CGemsTable>('created_at');

  /// The unique identifier of the chest the gem belongs to.
  static final chestID = PgStringColumn<CGemsTable>('chest_id');

  /// The lines of the story.
  static final lines = PgJoinToMany(
    joinColumn: id,
    joinedTableName: CLinesTable.tableName,
    foreignKey: 'lines_gem_id_fkey',
  );

  /// The token for sharing the gem.
  static final shareToken = PgMaybeJoinToOne(
    joinColumn: id,
    joinedTableName: CGemShareTokensTable.tableName,
    foreignKey: 'gem_share_tokens_gem_id_fkey',
  );
}
