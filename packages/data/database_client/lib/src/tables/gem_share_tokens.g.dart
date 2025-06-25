// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gem_share_tokens.dart';

// **************************************************************************
// PgUpsertGenerator
// **************************************************************************

// Typedefs are self-documenting.
// ignore_for_line: public_member_api_docs
typedef CGemShareTokensTableInsert = CGemShareTokensTableUpsert;

/// {@template CGemShareTokensTableUpsert}
///
/// Represents the data required to perform an insert or upsert operation on the
/// [CGemShareTokensTable] table.
///
/// {@endtemplate}
class CGemShareTokensTableUpsert extends PgUpsert<CGemShareTokensTable> {
  /// {@macro CGemShareTokensTableUpsert}
  CGemShareTokensTableUpsert({
    required this.chestID,
    required this.gemID,
    this.token,
  }) : super([
          CGemShareTokensTable.chestID(chestID),
          CGemShareTokensTable.gemID(gemID),
          if (token != null) CGemShareTokensTable.token(token),
        ]);

  final String chestID;
  final String gemID;
  final String? token;
}
