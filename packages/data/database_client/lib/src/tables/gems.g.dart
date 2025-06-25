// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gems.dart';

// **************************************************************************
// PgUpsertGenerator
// **************************************************************************

// Typedefs are self-documenting.
// ignore_for_line: public_member_api_docs
typedef CGemsTableInsert = CGemsTableUpsert;

/// {@template CGemsTableUpsert}
///
/// Represents the data required to perform an insert or upsert operation on the
/// [CGemsTable] table.
///
/// {@endtemplate}
class CGemsTableUpsert extends PgUpsert<CGemsTable> {
  /// {@macro CGemsTableUpsert}
  CGemsTableUpsert({
    required this.occurredAt,
    required this.chestID,
    this.createdAt,
    this.number,
    this.id,
  }) : super([
          CGemsTable.occurredAt(occurredAt),
          CGemsTable.chestID(chestID),
          if (createdAt != null) CGemsTable.createdAt(createdAt),
          if (number != null) CGemsTable.number(number),
          if (id != null) CGemsTable.id(id),
        ]);

  final DateTime occurredAt;
  final String chestID;
  final DateTime? createdAt;
  final int? number;
  final String? id;
}
