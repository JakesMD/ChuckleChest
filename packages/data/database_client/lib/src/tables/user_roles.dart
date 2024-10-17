// coverage:ignore-file

import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/src/tables/_tables.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'user_roles.g.dart';

/// {@template CUserRolesTable}
///
/// Represents the `user_roles` table in the Supabase database.
///
/// {@endtemplate}
@SupaTableHere()
class CUserRolesTable
    extends SupaTable<CUserRolesTableCore, CUserRolesTableRecord> {
  /// {@macro CUserRolesTable}
  const CUserRolesTable({required super.supabaseClient})
      : super(
          CUserRolesTableRecord.new,
          tableName: 'user_roles',
          primaryKey: const ['chest_id', 'user_id'],
        );

  /// The ID of the chest the user is a member of.
  @SupaColumnHere<String>()
  static const chestID =
      SupaColumn<CUserRolesTableCore, String, String>(name: 'chest_id');

  /// The ID of the member.
  @SupaColumnHere<String>()
  static const userID =
      SupaColumn<CUserRolesTableCore, String, String>(name: 'user_id');

  /// The role of the user.
  @SupaColumnHere<CUserRole>()
  static final role = SupaColumn<CUserRolesTableCore, CUserRole, String>(
    name: 'role',
    valueFromJSON: CUserRole.parse,
    valueToJSON: (value) => value.name,
  );

  /// The chest the invitation is for.
  @SupaTableJoinHere(
    'CChestsTable',
    'chests',
    SupaJoinType.oneToOne,
    isNullable: false,
  )
  static final chest = SupaTableJoin<CUserRolesTableCore, CChestsTableCore>(
    tableName: 'chests',
    joiningColumn: CUserRolesTable.chestID,
    record: CChestsTableRecord.new,
    joinType: SupaJoinType.oneToOne,
  );

  /// The user that the role is for.
  @SupaTableJoinHere(
    'CUsersTable',
    'users',
    SupaJoinType.oneToOne,
    isNullable: false,
  )
  static final user = SupaTableJoin<CUserRolesTableCore, CUsersTableCore>(
    tableName: 'users',
    joiningColumn: CUserRolesTable.userID,
    record: CUsersTableRecord.new,
    joinType: SupaJoinType.oneToOne,
  );
}
