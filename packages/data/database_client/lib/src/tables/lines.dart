// coverage:ignore-file

import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'lines.g.dart';

/// {@template CLinesTable}
///
/// Represents the `lines` table in the Supabase database.
///
/// {@endtemplate}
@SupaTableHere()
class CLinesTable extends SupaTable<CLinesTableCore, CLinesTableRecord> {
  /// {@macro CLinesTable}
  const CLinesTable({required super.supabaseClient})
      : super(
          CLinesTableRecord.new,
          tableName: 'lines',
          primaryKey: const ['id'],
        );

  /// The unique identifier of the line.
  @SupaColumnHere<BigInt>(hasDefault: true)
  static const id = SupaColumn<CLinesTableCore, BigInt, int>(name: 'id');

  /// The text of the line.
  @SupaColumnHere<String>()
  static const text = SupaColumn<CLinesTableCore, String, String>(name: 'text');

  /// The unique identifier of the person who said the line.
  @SupaColumnHere<BigInt?>()
  static const personID =
      SupaColumn<CLinesTableCore, BigInt?, int?>(name: 'person_id');

  /// The family or friend who is being quoted.
  @SupaTableJoinHere('CPeopleTable', 'people', SupaJoinType.oneToOne)
  static final person = SupaTableJoin<CLinesTableCore, CPeopleTableCore>(
    tableName: 'people',
    joiningColumn: CLinesTable.personID,
    record: CPeopleTableRecord.new,
    joinType: SupaJoinType.oneToOne,
    foreignKey: 'lines_person_id_fkey',
  );

  /// The unique identifier of the gem the line belongs to.
  @SupaColumnHere<String>()
  static const gemID = SupaColumn<CLinesTableCore, String, String>(
    name: 'gem_id',
  );

  /// The unique identifier of the chest the line belongs to.
  @SupaColumnHere<String>()
  static const chestID = SupaColumn<CLinesTableCore, String, String>(
    name: 'chest_id',
  );
}
