// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people.dart';

// **************************************************************************
// PgUpsertGenerator
// **************************************************************************

// Typedefs are self-documenting.
// ignore_for_line: public_member_api_docs
typedef CPeopleTableInsert = CPeopleTableUpsert;

/// {@template CPeopleTableUpsert}
///
/// Represents the data required to perform an insert or upsert operation on the
/// [CPeopleTable] table.
///
/// {@endtemplate}
class CPeopleTableUpsert extends PgUpsert<CPeopleTable> {
  /// {@macro CPeopleTableUpsert}
  CPeopleTableUpsert({
    required this.nickname,
    required this.dateOfBirth,
    required this.chestID,
    this.id,
  }) : super([
          CPeopleTable.nickname(nickname),
          CPeopleTable.dateOfBirth(dateOfBirth),
          CPeopleTable.chestID(chestID),
          if (id != null) CPeopleTable.id(id),
        ]);

  final String nickname;
  final DateTime dateOfBirth;
  final String chestID;
  final BigInt? id;
}
