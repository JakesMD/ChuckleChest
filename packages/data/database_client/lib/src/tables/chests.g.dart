// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chests.dart';

// **************************************************************************
// SupaTableGenerator
// **************************************************************************

// ignore_for_file: strict_raw_type
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

/// The base class that links all classes for [CChestsTable] together
/// to create full type safety.
base class CChestsTableCore extends SupaCore {}

/// {@template CChestsTableRecord}
///
/// Represents a record fetched from [CChestsTable].
///
/// {@endtemplate}
class CChestsTableRecord extends SupaRecord<CChestsTableCore> {
  /// {@macro CChestsTableRecord}
  const CChestsTableRecord(super.json);

  /// The unique identifier of the chests.
  ///
  /// This will throw an exception if the column was not fetched.
  String get id => call(CChestsTable.id);

  /// The name of the chest.
  ///
  /// This will throw an exception if the column was not fetched.
  String get name => call(CChestsTable.name);
}

/// {@template CChestsTableInsert}
///
/// Represents an insert operation on [CChestsTable].
///
/// {@endtemplate}
class CChestsTableInsert extends SupaInsert<CChestsTableCore> {
  /// {@macro CChestsTableInsert}
  const CChestsTableInsert({
    this.id,
    required this.name,
  });

  /// The unique identifier of the chests.
  final String? id;

  /// The name of the chest.
  final String name;

  @override
  Set<SupaValue<CChestsTableCore, dynamic, dynamic>> get values => {
        if (id != null) CChestsTable.id(id!),
        CChestsTable.name(name),
      };
}
