import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'lines.g.dart';

/// {@template CLinesTable}
///
/// Represents the `lines` table in the Supabase database.
///
/// {@endtemplate}
@PgTableHere()
class CLinesTable extends SupabaseTable<CLinesTable> {
  /// {@macro CLinesTable}
  CLinesTable(super.client) : super(tableName: tableName, primaryKey: [id]);

  /// The name of the table in the Supabase database.
  static const tableName = PgTableName<CLinesTable>('lines');

  /// The unique identifier of the line.
  @PgColumnHasDefault()
  static final id = PgBigIntColumn<CLinesTable>('id');

  /// The text of the line.
  static final text = PgStringColumn<CLinesTable>('text');

  /// The unique identifier of the person who said the line.
  static final personID = PgMaybeBigIntColumn<CLinesTable>('person_id');

  /// The unique identifier of the gem the line belongs to.
  static final gemID = PgStringColumn<CLinesTable>('gem_id');

  /// The unique identifier of the chest the line belongs to.
  static final chestID = PgStringColumn<CLinesTable>('chest_id');

  /// The family or friend who is being quoted.
  static final person = PgMaybeJoinToOne<CLinesTable, CPeopleTable>(
    joinColumn: personID,
    joinedTableName: CPeopleTable.tableName,
    foreignKey: 'lines_person_id_fkey',
  );
}
