// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people.dart';

// **************************************************************************
// SupaTableGenerator
// **************************************************************************

// ignore_for_file: strict_raw_type
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

/// The base class that links all classes for [CPeopleTable] together
/// to create full type safety.
base class CPeopleTableCore extends SupaCore {}

/// {@template CPeopleTableRecord}
///
/// Represents a record fetched from [CPeopleTable].
///
/// {@endtemplate}
class CPeopleTableRecord extends SupaRecord<CPeopleTableCore> {
  /// {@macro CPeopleTableRecord}
  const CPeopleTableRecord(super.json);

  /// The unique identifier of the line.
  ///
  /// This will throw an exception if the column was not fetched.
  BigInt get id => call(CPeopleTable.id);

  /// The nickname of the person who made the person.
  ///
  /// This will throw an exception if the column was not fetched.
  String get nickname => call(CPeopleTable.nickname);

  /// The date of birth of the person who made the person.
  ///
  /// This will throw an exception if the column was not fetched.
  DateTime get dateOfBirth => call(CPeopleTable.dateOfBirth);

  /// The unique identifier of the chest to which the person belongs.
  ///
  /// This will throw an exception if the column was not fetched.
  String get chestID => call(CPeopleTable.chestID);

  /// The URLs of the photos of the person at different ages.
  /// The family or friend who is being quoted.
  ///
  /// This will throw an exception if no joined columns were fetched.
  ///
  /// An InvalidType error here is often caused by a misspelling of the prefix in the @SupaTableJoinHere annotation.
  List<CAvatarsTableRecord> get avatarURLs =>
      reference(CPeopleTable.avatarURLs);
}

/// {@template CPeopleTableInsert}
///
/// Represents an insert operation on [CPeopleTable].
///
/// {@endtemplate}
class CPeopleTableInsert extends SupaInsert<CPeopleTableCore> {
  /// {@macro CPeopleTableInsert}
  const CPeopleTableInsert({
    this.id,
    required this.nickname,
    required this.dateOfBirth,
    required this.chestID,
  });

  /// The unique identifier of the line.
  final BigInt? id;

  /// The nickname of the person who made the person.
  final String nickname;

  /// The date of birth of the person who made the person.
  final DateTime dateOfBirth;

  /// The unique identifier of the chest to which the person belongs.
  final String chestID;

  @override
  Set<SupaValue<CPeopleTableCore, dynamic, dynamic>> get values => {
        if (id != null) CPeopleTable.id(id!),
        CPeopleTable.nickname(nickname),
        CPeopleTable.dateOfBirth(dateOfBirth),
        CPeopleTable.chestID(chestID),
      };
}
