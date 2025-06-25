// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitations.dart';

// **************************************************************************
// PgUpsertGenerator
// **************************************************************************

// Typedefs are self-documenting.
// ignore_for_line: public_member_api_docs
typedef CInvitationsTableInsert = CInvitationsTableUpsert;

/// {@template CInvitationsTableUpsert}
///
/// Represents the data required to perform an insert or upsert operation on the
/// [CInvitationsTable] table.
///
/// {@endtemplate}
class CInvitationsTableUpsert extends PgUpsert<CInvitationsTable> {
  /// {@macro CInvitationsTableUpsert}
  CInvitationsTableUpsert({
    required this.email,
    required this.chestID,
    required this.assignedRole,
  }) : super([
          CInvitationsTable.email(email),
          CInvitationsTable.chestID(chestID),
          CInvitationsTable.assignedRole(assignedRole),
        ]);

  final String email;
  final String chestID;
  final CUserRole assignedRole;
}
