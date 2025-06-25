// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chests.dart';

// **************************************************************************
// PgUpsertGenerator
// **************************************************************************

// Typedefs are self-documenting.
// ignore_for_line: public_member_api_docs
typedef CChestsTableInsert = CChestsTableUpsert;

/// {@template CChestsTableUpsert}
///
/// Represents the data required to perform an insert or upsert operation on the
/// [CChestsTable] table.
///
/// {@endtemplate}
class CChestsTableUpsert extends PgUpsert<CChestsTable> {
  /// {@macro CChestsTableUpsert}
  CChestsTableUpsert({
    required this.name,
    this.id,
  }) : super([
          CChestsTable.name(name),
          if (id != null) CChestsTable.id(id),
        ]);

  final String name;
  final String? id;
}
