// coverage:ignore-file

import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/src/tables/_tables.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'invitations.g.dart';

/// {@template CInvitationsTable}
///
/// Represents the `invitations` table in the Supabase database.
///
/// {@endtemplate}
@SupaTableHere()
class CInvitationsTable
    extends SupaTable<CInvitationsTableCore, CInvitationsTableRecord> {
  /// {@macro CInvitationsTable}
  const CInvitationsTable({required super.supabaseClient})
      : super(
          CInvitationsTableRecord.new,
          tableName: 'invitations',
          primaryKey: const ['chest_id', 'email'],
        );

  /// The email of the person invited.
  @SupaColumnHere<String>()
  static const email =
      SupaColumn<CInvitationsTableCore, String, String>(name: 'email');

  /// The assigned role of the person invited.
  @SupaColumnHere<CUserRole>()
  static final assignedRole =
      SupaColumn<CInvitationsTableCore, CUserRole, String>(
    name: 'assigned_role',
    valueFromJSON: CUserRole.parse,
    valueToJSON: (value) => value.name,
  );

  /// The ID of the chest the invitation is for.
  @SupaColumnHere<String>()
  static const chestID =
      SupaColumn<CInvitationsTableCore, String, String>(name: 'chest_id');

  /// The chest the invitation is for.
  @SupaTableJoinHere(
    'CChestsTable',
    'chests',
    SupaJoinType.oneToOne,
    isNullable: false,
  )
  static final chest = SupaTableJoin<CInvitationsTableCore, CChestsTableCore>(
    tableName: 'chests',
    joiningColumn: CInvitationsTable.chestID,
    record: CChestsTableRecord.new,
    joinType: SupaJoinType.oneToOne,
  );
}
