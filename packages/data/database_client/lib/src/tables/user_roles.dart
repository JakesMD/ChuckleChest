import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/src/tables/_tables.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'user_roles.g.dart';

/// {@template CUserRolesTable}
///
/// Represents the `user_roles` table in the Supabase database.
///
/// {@endtemplate}
@PgTableHere()
class CUserRolesTable extends SupabaseTable<CUserRolesTable> {
  /// {@macro CUserRolesTable}
  CUserRolesTable(super.client)
      : super(tableName: tableName, primaryKey: [chestID, userID]);

  /// The name of the table in the Supabase database.
  static const tableName = PgTableName<CUserRolesTable>('user_roles');

  /// The ID of the chest the user is a member of.
  static final chestID = PgStringColumn<CUserRolesTable>('chest_id');

  /// The ID of the member.
  static final userID = PgStringColumn<CUserRolesTable>('user_id');

  /// The role of the user.
  static final role = PgColumn<CUserRolesTable, CUserRole, String>(
    'role',
    fromJson: CUserRole.parse,
    toJson: (value) => value.name,
  );

  /// The chest the invitation is for.
  static final chest = PgJoinToOne<CUserRolesTable, CChestsTable>(
    joinColumn: chestID,
    joinedTableName: CChestsTable.tableName,
  );

  /// The user that the role is for.
  static final user = PgJoinToOne<CUserRolesTable, CUsersTable>(
    joinColumn: userID,
    joinedTableName: CUsersTable.tableName,
  );
}
