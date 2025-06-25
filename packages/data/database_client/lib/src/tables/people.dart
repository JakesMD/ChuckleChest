import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'people.g.dart';

/// {@template CPeopleTable}
///
/// Represents the `people` table in the Supabase database.
///
/// {@endtemplate}
@PgTableHere()
class CPeopleTable extends SupabaseTable<CPeopleTable> {
  /// {@macro CPeopleTable}
  CPeopleTable(super.client) : super(tableName: tableName, primaryKey: [id]);

  /// The name of the table in the Supabase database.
  static const tableName = PgTableName<CPeopleTable>('people');

  /// The unique identifier of the line.
  @PgColumnHasDefault()
  static final id = PgBigIntColumn<CPeopleTable>('id');

  /// The nickname of the person who made the person.
  static final nickname = PgStringColumn<CPeopleTable>('nickname');

  /// The date of birth of the person who made the person.
  static final dateOfBirth = PgUTCDateTimeColumn<CPeopleTable>('date_of_birth');

  /// The unique identifier of the chest to which the person belongs.
  static final chestID = PgStringColumn<CPeopleTable>('chest_id');

  /// The URLs of the photos of the person at different ages.
  /// The family or friend who is being quoted.
  static final avatars = PgJoinToMany<CPeopleTable, CAvatarsTable>(
    joinColumn: id,
    joinedTableName: CAvatarsTable.tableName,
    foreignKey: 'connection_avatar_urls_connection_id_fkey',
  );
}
