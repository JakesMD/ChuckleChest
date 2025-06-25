import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/src/tables/_tables.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'invitations.g.dart';

/// {@template CInvitationsTable}
///
/// Represents the `invitations` table in the Supabase database.
///
/// {@endtemplate}
@PgTableHere()
class CInvitationsTable extends SupabaseTable<CInvitationsTable> {
  /// {@macro CInvitationsTable}
  CInvitationsTable(super.client)
      : super(tableName: tableName, primaryKey: [chestID, email]);

  /// The name of the table in the Supabase database.
  static const tableName = PgTableName<CInvitationsTable>('invitations');

  /// The email of the person invited.
  static final email = PgStringColumn<CInvitationsTable>('email');

  /// The ID of the chest the invitation is for.
  static final chestID = PgStringColumn<CInvitationsTable>('chest_id');

  /// The assigned role of the person invited.
  static final assignedRole = PgColumn<CInvitationsTable, CUserRole, String>(
    'assigned_role',
    fromJson: CUserRole.parse,
    toJson: (value) => value.name,
  );

  /// The chest the invitation is for.
  static final chest = PgJoinToOne(
    joinColumn: chestID,
    joinedTableName: CChestsTable.tableName,
  );
}
