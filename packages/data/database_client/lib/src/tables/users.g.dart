// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// PgUpsertGenerator
// **************************************************************************

// Typedefs are self-documenting.
// ignore_for_line: public_member_api_docs
typedef CUsersTableInsert = CUsersTableUpsert;

/// {@template CUsersTableUpsert}
///
/// Represents the data required to perform an insert or upsert operation on the
/// [CUsersTable] table.
///
/// {@endtemplate}
class CUsersTableUpsert extends PgUpsert<CUsersTable> {
  /// {@macro CUsersTableUpsert}
  CUsersTableUpsert({
    required this.id,
    this.username,
  }) : super([
          CUsersTable.id(id),
          if (username != null) CUsersTable.username(username.value),
        ]);

  final String id;
  final PgNullable<String>? username;
}
