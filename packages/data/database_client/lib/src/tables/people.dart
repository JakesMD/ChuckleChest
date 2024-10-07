// coverage:ignore-file

import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'people.g.dart';

/// {@template CPeopleTable}
///
/// Represents the `people` table in the Supabase database.
///
/// {@endtemplate}
@SupaTableHere()
class CPeopleTable extends SupaTable<CPeopleTableCore, CPeopleTableRecord> {
  /// {@macro CPeopleTable}
  const CPeopleTable({required super.supabaseClient})
      : super(
          CPeopleTableRecord.new,
          tableName: 'people',
          primaryKey: const ['id'],
        );

  /// The unique identifier of the line.
  @SupaColumnHere<BigInt>(hasDefault: true)
  static const id = SupaColumn<CPeopleTableCore, BigInt, int>(name: 'id');

  /// The nickname of the person who made the person.
  @SupaColumnHere<String>()
  static const nickname =
      SupaColumn<CPeopleTableCore, String, String>(name: 'nickname');

  /// The date of birth of the person who made the person.
  @SupaColumnHere<DateTime>()
  static const dateOfBirth =
      SupaColumn<CPeopleTableCore, DateTime, String>(name: 'date_of_birth');

  /// The URLs of the photos of the person at different ages.
  /// The family or friend who is being quoted.
  @SupaTableJoinHere(
    'CAvatarsTable',
    'avatars',
    SupaJoinType.oneToMany,
  )
  static final avatarURLs = SupaTableJoin<CPeopleTableCore, CAvatarsTableCore>(
    tableName: 'avatars',
    joiningColumn: CPeopleTable.id,
    record: CAvatarsTableRecord.new,
    joinType: SupaJoinType.oneToMany,
    foreignKey: 'connection_avatar_urls_connection_id_fkey',
  );

  /// The unique identifier of the chest to which the person belongs.
  @SupaColumnHere<String>()
  static const chestID =
      SupaColumn<CPeopleTableCore, String, String>(name: 'chest_id');
}
