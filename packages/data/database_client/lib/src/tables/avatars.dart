import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'avatars.g.dart';

/// {@template CAvatarsTable}
///
/// Represents the `avatars` table in the Supabase database.
///
/// {@endtemplate}
@PgTableHere()
class CAvatarsTable extends SupabaseTable<CAvatarsTable> {
  /// {@macro CAvatarsTable}
  CAvatarsTable(super.client)
      : super(tableName: tableName, primaryKey: [personID, year]);

  /// The name of the table in the Supabase database.
  static const tableName = PgTableName<CAvatarsTable>('avatars');

  /// The unique identifier of the person.
  static final personID = PgBigIntColumn<CAvatarsTable>('person_id');

  /// The year the photo was taken.
  static final year = PgIntColumn<CAvatarsTable>('year');

  /// The URL of the photo of the person at that age.
  static final imageURL = PgStringColumn<CAvatarsTable>('image_url');

  /// The ID of the chest the person belongs to.
  static final chestID = PgStringColumn<CAvatarsTable>('chest_id');
}
