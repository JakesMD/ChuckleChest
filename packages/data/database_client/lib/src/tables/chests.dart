import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'chests.g.dart';

/// {@template CChestsTable}
///
/// Represents the `chests` table in the Supabase database.
///
/// {@endtemplate}
@PgTableHere()
class CChestsTable extends SupabaseTable<CChestsTable> {
  /// {@macro CChestsTable}
  CChestsTable(super.client) : super(tableName: tableName, primaryKey: [id]);

  /// The name of the table in the Supabase database.
  static const tableName = PgTableName<CChestsTable>('chests');

  /// The unique identifier of the chests.
  @PgColumnHasDefault()
  static final id = PgStringColumn<CChestsTable>('id');

  /// The name of the chest.
  static final name = PgStringColumn<CChestsTable>('name');
}
