// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_roles.dart';

// **************************************************************************
// PgUpsertGenerator
// **************************************************************************

// Typedefs are self-documenting.
// ignore_for_line: public_member_api_docs
typedef CUserRolesTableInsert = CUserRolesTableUpsert;

/// {@template CUserRolesTableUpsert}
///
/// Represents the data required to perform an insert or upsert operation on the
/// [CUserRolesTable] table.
///
/// {@endtemplate}
class CUserRolesTableUpsert extends PgUpsert<CUserRolesTable> {
  /// {@macro CUserRolesTableUpsert}
  CUserRolesTableUpsert({
    required this.chestID,
    required this.userID,
    required this.role,
  }) : super([
          CUserRolesTable.chestID(chestID),
          CUserRolesTable.userID(userID),
          CUserRolesTable.role(role),
        ]);

  final String chestID;
  final String userID;
  final CUserRole role;
}
