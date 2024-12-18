// coverage:ignore-file

import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'gems.g.dart';

/// {@template CGemsTable}
///
/// Represents the `gems` table in the Supabase database.
///
/// {@endtemplate}
@SupaTableHere()
class CGemsTable extends SupaTable<CGemsTableCore, CGemsTableRecord> {
  /// {@macro CGemsTable}
  const CGemsTable({required super.supabaseClient})
      : super(
          CGemsTableRecord.new,
          tableName: 'gems',
          primaryKey: const ['id'],
        );

  /// The unique identifier of the gem.
  @SupaColumnHere<String>(hasDefault: true)
  static const id = SupaColumn<CGemsTableCore, String, String>(name: 'id');

  /// The number of the gem.
  @SupaColumnHere<int>(hasDefault: true)
  static const number = SupaColumn<CGemsTableCore, int, int>(name: 'number');

  /// The date and time when the story occurred.
  @SupaColumnHere<DateTime>()
  static const occurredAt = SupaColumn<CGemsTableCore, DateTime, String>(
    name: 'occurred_at',
  );

  /// The time the gem was created.
  @SupaColumnHere<DateTime>(hasDefault: true)
  static const createdAt = SupaColumn<CGemsTableCore, DateTime, String>(
    name: 'created_at',
  );

  /// The lines of the story.
  @SupaTableJoinHere('CLinesTable', 'lines', SupaJoinType.oneToMany)
  static final lines = SupaTableJoin<CGemsTableCore, CLinesTableCore>(
    tableName: 'lines',
    joiningColumn: CGemsTable.id,
    record: CLinesTableRecord.new,
    joinType: SupaJoinType.oneToMany,
    foreignKey: 'lines_gem_id_fkey',
  );

  /// The unique identifier of the chest the gem belongs to.
  @SupaColumnHere<String>()
  static const chestID = SupaColumn<CGemsTableCore, String, String>(
    name: 'chest_id',
  );

  /// The token for sharing the gem.
  @SupaTableJoinHere(
    'CGemShareTokensTable',
    'gem_share_tokens',
    SupaJoinType.oneToOne,
  )
  static final shareToken =
      SupaTableJoin<CGemsTableCore, CGemShareTokensTableCore>(
    tableName: 'gem_share_tokens',
    joiningColumn: CGemsTable.id,
    record: CGemShareTokensTableRecord.new,
    joinType: SupaJoinType.oneToOne,
    foreignKey: 'gem_share_tokens_gem_id_fkey',
  );
}
