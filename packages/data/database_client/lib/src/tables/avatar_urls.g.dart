// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_urls.dart';

// **************************************************************************
// SupaTableGenerator
// **************************************************************************

// ignore_for_file: strict_raw_type
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

/// The base class that links all classes for [CAvatarURLsTable] together
/// to create full type safety.
base class CAvatarURLsTableCore extends SupaCore {}

/// {@template CAvatarURLsTableRecord}
///
/// Represents a record fetched from [CAvatarURLsTable].
///
/// {@endtemplate}
class CAvatarURLsTableRecord extends SupaRecord<CAvatarURLsTableCore> {
  /// {@macro CAvatarURLsTableRecord}
  const CAvatarURLsTableRecord(super.json);

  /// The unique identifier of the person.
  ///
  /// This will throw an exception if the column was not fetched.
  BigInt get personID => call(CAvatarURLsTable.personID);

  /// The URL of the photo of the person at that age.
  ///
  /// This will throw an exception if the column was not fetched.
  String get url => call(CAvatarURLsTable.url);

  /// The age of the person at the time the photo was taken.
  ///
  /// This will throw an exception if the column was not fetched.
  int get age => call(CAvatarURLsTable.age);
}

/// {@template CAvatarURLsTableInsert}
///
/// Represents an insert operation on [CAvatarURLsTable].
///
/// {@endtemplate}
class CAvatarURLsTableInsert extends SupaInsert<CAvatarURLsTableCore> {
  /// {@macro CAvatarURLsTableInsert}
  const CAvatarURLsTableInsert({
    required this.personID,
    required this.url,
    required this.age,
  });

  /// The unique identifier of the person.
  final BigInt personID;

  /// The URL of the photo of the person at that age.
  final String url;

  /// The age of the person at the time the photo was taken.
  final int age;

  @override
  Set<SupaValue<CAvatarURLsTableCore, dynamic, dynamic>> get values => {
        CAvatarURLsTable.personID(personID),
        CAvatarURLsTable.url(url),
        CAvatarURLsTable.age(age),
      };
}
