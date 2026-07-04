// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gem_likes.dart';

// **************************************************************************
// PgUpsertGenerator
// **************************************************************************

// Typedefs are self-documenting.
// ignore_for_line: public_member_api_docs
typedef CGemLikesTableInsert = CGemLikesTableUpsert;

/// {@template CGemLikesTableUpsert}
///
/// Represents the data required to perform an insert or upsert operation on the
/// [CGemLikesTable] table.
///
/// {@endtemplate}
class CGemLikesTableUpsert extends PgUpsert<CGemLikesTable> {
  /// {@macro CGemLikesTableUpsert}
  CGemLikesTableUpsert({
    required this.chestID,
    required this.gemID,
    this.likedAt,
    this.userID,
  }) : super([
         CGemLikesTable.chestID(chestID),
         CGemLikesTable.gemID(gemID),
         if (likedAt != null) CGemLikesTable.likedAt(likedAt),
         if (userID != null) CGemLikesTable.userID(userID),
       ]);

  final String chestID;
  final String gemID;
  final DateTime? likedAt;
  final String? userID;
}
