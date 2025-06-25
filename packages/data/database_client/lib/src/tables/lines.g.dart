// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lines.dart';

// **************************************************************************
// PgUpsertGenerator
// **************************************************************************

// Typedefs are self-documenting.
// ignore_for_line: public_member_api_docs
typedef CLinesTableInsert = CLinesTableUpsert;

/// {@template CLinesTableUpsert}
///
/// Represents the data required to perform an insert or upsert operation on the
/// [CLinesTable] table.
///
/// {@endtemplate}
class CLinesTableUpsert extends PgUpsert<CLinesTable> {
  /// {@macro CLinesTableUpsert}
  CLinesTableUpsert({
    required this.text,
    this.personID,
    required this.gemID,
    required this.chestID,
    this.id,
  }) : super([
          CLinesTable.text(text),
          if (personID != null) CLinesTable.personID(personID.value),
          CLinesTable.gemID(gemID),
          CLinesTable.chestID(chestID),
          if (id != null) CLinesTable.id(id),
        ]);

  final String text;
  final PgNullable<BigInt>? personID;
  final String gemID;
  final String chestID;
  final BigInt? id;
}
