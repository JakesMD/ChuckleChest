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
      : super(CLinesTableRecord.new, tableName: 'lines', primaryKey: 'id');

  /// The unique identifier of the line.
  @SupaColumnHere<BigInt>()
  static const id = SupaColumn<CLinesTableCore, BigInt, int>(name: 'id');

  /// The text of the line.
  @SupaColumnHere<String>()
  static const text = SupaColumn<CLinesTableCore, String, String>(name: 'text');

  /// The family or friend who is being quoted.
  @SupaTableJoinHere('CPeopleTable', 'people', SupaJoinType.oneToOne)
  static final person = SupaTableJoin<CLinesTableCore, CPeopleTableCore>(
    tableName: 'people',
    joiningColumn: CLinesTable.id,
    record: CPeopleTableRecord.new,
    joinType: SupaJoinType.oneToOne,
  );
}

void main() {
  throw Error();
}
