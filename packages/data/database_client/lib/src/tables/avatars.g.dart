// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatars.dart';

// **************************************************************************
// SupaTableGenerator
// **************************************************************************

// ignore_for_file: strict_raw_type
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

/// The base class that links all classes for [CAvatarsTable] together
/// to create full type safety.
base class CAvatarsTableCore extends SupaCore {}

/// {@template CAvatarsTableRecord}
///
/// Represents a record fetched from [CAvatarsTable].
///
/// {@endtemplate}
class CAvatarsTableRecord extends SupaRecord<CAvatarsTableCore> {
  /// {@macro CAvatarsTableRecord}
  const CAvatarsTableRecord(super.json);

  /// The unique identifier of the person.
  ///
  /// This will throw an exception if the column was not fetched.
  BigInt get personID => call(CAvatarsTable.personID);

  /// The year the photo was taken.
  ///
  /// This will throw an exception if the column was not fetched.
  int get year => call(CAvatarsTable.year);

  /// The URL of the photo of the person at that age.
  ///
  /// This will throw an exception if the column was not fetched.
  String get imageURL => call(CAvatarsTable.imageURL);

  /// The ID of the chest the person belongs to.
  ///
  /// This will throw an exception if the column was not fetched.
  String get chestID => call(CAvatarsTable.chestID);
}

/// {@template CAvatarsTableInsert}
///
/// Represents an insert operation on [CAvatarsTable].
///
/// {@endtemplate}
class CAvatarsTableInsert extends SupaInsert<CAvatarsTableCore> {
  /// {@macro CAvatarsTableInsert}
  const CAvatarsTableInsert({
    required this.personID,
    required this.year,
    required this.imageURL,
    required this.chestID,
  });

  /// The unique identifier of the person.
  final BigInt personID;

  /// The year the photo was taken.
  final int year;

  /// The URL of the photo of the person at that age.
  final String imageURL;

  /// The ID of the chest the person belongs to.
  final String chestID;

  @override
  Set<SupaValue<CAvatarsTableCore, dynamic, dynamic>> get values => {
        CAvatarsTable.personID(personID),
        CAvatarsTable.year(year),
        CAvatarsTable.imageURL(imageURL),
        CAvatarsTable.chestID(chestID),
      };
}
