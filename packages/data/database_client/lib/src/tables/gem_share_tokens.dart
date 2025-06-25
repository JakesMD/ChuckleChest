import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'gem_share_tokens.g.dart';

/// {@template CGemShareTokensTable}
///
/// Represents the `gem_share_tokens` table in the Supabase database.
///
/// {@endtemplate}
@PgTableHere()
class CGemShareTokensTable extends SupabaseTable<CGemShareTokensTable> {
  /// {@macro CGemShareTokensTable}
  CGemShareTokensTable(super.client)
      : super(tableName: tableName, primaryKey: [gemID]);

  /// The name of the table in the Supabase database.
  static const tableName =
      PgTableName<CGemShareTokensTable>('gem_share_tokens');

  /// The ID of the chest the gem belongs to.
  static final chestID = PgStringColumn<CGemShareTokensTable>('chest_id');

  /// The ID of the gem.
  static final gemID = PgStringColumn<CGemShareTokensTable>('gem_id');

  /// The token for sharing the gem.
  @PgColumnHasDefault()
  static final token = PgStringColumn<CGemShareTokensTable>('token');
}
