// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatars.dart';

// **************************************************************************
// PgUpsertGenerator
// **************************************************************************

// Typedefs are self-documenting.
// ignore_for_line: public_member_api_docs
typedef CAvatarsTableInsert = CAvatarsTableUpsert;

/// {@template CAvatarsTableUpsert}
///
/// Represents the data required to perform an insert or upsert operation on the
/// [CAvatarsTable] table.
///
/// {@endtemplate}
class CAvatarsTableUpsert extends PgUpsert<CAvatarsTable> {
  /// {@macro CAvatarsTableUpsert}
  CAvatarsTableUpsert({
    required this.personID,
    required this.year,
    required this.imageURL,
    required this.chestID,
  }) : super([
          CAvatarsTable.personID(personID),
          CAvatarsTable.year(year),
          CAvatarsTable.imageURL(imageURL),
          CAvatarsTable.chestID(chestID),
        ]);

  final BigInt personID;
  final int year;
  final String imageURL;
  final String chestID;
}
