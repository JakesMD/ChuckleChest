// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lines.dart';

// **************************************************************************
// SupaTableGenerator
// **************************************************************************

// ignore_for_file: strict_raw_type
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

/// The base class that links all classes for [CLinesTable] together
/// to create full type safety.
base class CLinesTableCore extends SupaCore {}

/// {@template CLinesTableRecord}
///
/// Represents a record fetched from [CLinesTable].
///
/// {@endtemplate}
class CLinesTableRecord extends SupaRecord<CLinesTableCore> {
  /// {@macro CLinesTableRecord}
  const CLinesTableRecord(super.json);

  /// The unique identifier of the line.
  ///
  /// This will throw an exception if the column was not fetched.
  BigInt get id => call(CLinesTable.id);

  /// The text of the line.
  ///
  /// This will throw an exception if the column was not fetched.
  String get text => call(CLinesTable.text);

  /// The unique identifier of the person who said the line.
  ///
  /// This will throw an exception if the column was not fetched.
  BigInt? get personID => call(CLinesTable.personID);

  /// The unique identifier of the gem the line belongs to.
  ///
  /// This will throw an exception if the column was not fetched.
  String get gemID => call(CLinesTable.gemID);

  /// The unique identifier of the chest the line belongs to.
  ///
  /// This will throw an exception if the column was not fetched.
  String get chestID => call(CLinesTable.chestID);

  /// The family or friend who is being quoted.
  ///
  /// This will throw an exception if no joined columns were fetched.
  ///
  /// An InvalidType error here is often caused by a misspelling of the prefix in the @SupaTableJoinHere annotation.
  CPeopleTableRecord? get person => referenceSingle(CLinesTable.person);
}

/// {@template CLinesTableInsert}
///
/// Represents an insert operation on [CLinesTable].
///
/// {@endtemplate}
class CLinesTableInsert extends SupaInsert<CLinesTableCore> {
  /// {@macro CLinesTableInsert}
  const CLinesTableInsert({
    this.id,
    required this.text,
    this.personID,
    required this.gemID,
    required this.chestID,
  });

  /// The unique identifier of the line.
  final BigInt? id;

  /// The text of the line.
  final String text;

  /// The unique identifier of the person who said the line.
  final BigInt? personID;

  /// The unique identifier of the gem the line belongs to.
  final String gemID;

  /// The unique identifier of the chest the line belongs to.
  final String chestID;

  @override
  Set<SupaValue<CLinesTableCore, dynamic, dynamic>> get values => {
        if (id != null) CLinesTable.id(id!),
        CLinesTable.text(text),
        if (personID != null) CLinesTable.personID(personID),
        CLinesTable.gemID(gemID),
        CLinesTable.chestID(chestID),
      };
}
