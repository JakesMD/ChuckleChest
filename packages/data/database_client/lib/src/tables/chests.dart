import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'chests.g.dart';

/// {@template CChestsTable}
///
/// Represents the `chests` table in the Supabase database.
///
/// {@endtemplate}
@SupaTableHere()
class CChestsTable extends SupaTable<CChestsTableCore, CChestsTableRecord> {
  /// {@macro CChestsTable}
  const CChestsTable({required super.supabaseClient})
      : super(CChestsTableRecord.new, tableName: 'chests', primaryKey: 'id');

  /// The unique identifier of the chests.
  @SupaColumnHere<String>(hasDefault: true)
  static const id = SupaColumn<CChestsTableCore, String, String>(name: 'id');

  /// The name of the chest.
  @SupaColumnHere<String>()
  static const name =
      SupaColumn<CChestsTableCore, String, String>(name: 'name');
}
