// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gems.dart';

// **************************************************************************
// SupaTableGenerator
// **************************************************************************

// ignore_for_file: strict_raw_type
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

/// The base class that links all classes for [CGemsTable] together
/// to create full type safety.
base class CGemsTableCore extends SupaCore {}

/// {@template CGemsTableRecord}
///
/// Represents a record fetched from [CGemsTable].
///
/// {@endtemplate}
class CGemsTableRecord extends SupaRecord<CGemsTableCore> {
  /// {@macro CGemsTableRecord}
  const CGemsTableRecord(super.json);

  /// The unique identifier of the gem.
  ///
  /// This will throw an exception if the column was not fetched.
  String get id => call(CGemsTable.id);

  /// The number of the gem.
  ///
  /// This will throw an exception if the column was not fetched.
  int get number => call(CGemsTable.number);

  /// The date and time when the story occurred.
  ///
  /// This will throw an exception if the column was not fetched.
  DateTime get occurredAt => call(CGemsTable.occurredAt);

  /// The lines of the story.
  ///
  /// This will throw an exception if no joined columns were fetched.
  List<CLinesTableRecord> get lines => reference(CGemsTable.lines);
}

/// {@template CGemsTableInsert}
///
/// Represents an insert operation on [CGemsTable].
///
/// {@endtemplate}
class CGemsTableInsert extends SupaInsert<CGemsTableCore> {
  /// {@macro CGemsTableInsert}
  const CGemsTableInsert({
    this.id,
    required this.number,
    required this.occurredAt,
  });

  /// The unique identifier of the gem.
  final String? id;

  /// The number of the gem.
  final int number;

  /// The date and time when the story occurred.
  final DateTime occurredAt;

  @override
  Set<SupaValue<CGemsTableCore, dynamic, dynamic>> get values => {
        if (id != null) CGemsTable.id(id!),
        CGemsTable.number(number),
        CGemsTable.occurredAt(occurredAt),
      };
}
