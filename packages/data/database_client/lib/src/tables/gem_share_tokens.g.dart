// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gem_share_tokens.dart';

// **************************************************************************
// SupaTableGenerator
// **************************************************************************

// ignore_for_file: strict_raw_type
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

/// The base class that links all classes for [CGemShareTokensTable] together
/// to create full type safety.
base class CGemShareTokensTableCore extends SupaCore {}

/// {@template CGemShareTokensTableRecord}
///
/// Represents a record fetched from [CGemShareTokensTable].
///
/// {@endtemplate}
class CGemShareTokensTableRecord extends SupaRecord<CGemShareTokensTableCore> {
  /// {@macro CGemShareTokensTableRecord}
  const CGemShareTokensTableRecord(super.json);

  /// The ID of the chest the gem belongs to.
  ///
  /// This will throw an exception if the column was not fetched.
  String get chestID => call(CGemShareTokensTable.chestID);

  /// The ID of the gem.
  ///
  /// This will throw an exception if the column was not fetched.
  String get gemID => call(CGemShareTokensTable.gemID);

  /// The token for sharing the gem.
  ///
  /// This will throw an exception if the column was not fetched.
  String get token => call(CGemShareTokensTable.token);
}

/// {@template CGemShareTokensTableInsert}
///
/// Represents an insert operation on [CGemShareTokensTable].
///
/// {@endtemplate}
class CGemShareTokensTableInsert extends SupaInsert<CGemShareTokensTableCore> {
  /// {@macro CGemShareTokensTableInsert}
  const CGemShareTokensTableInsert({
    required this.chestID,
    required this.gemID,
    this.token,
  });

  /// The ID of the chest the gem belongs to.
  final String chestID;

  /// The ID of the gem.
  final String gemID;

  /// The token for sharing the gem.
  final String? token;

  @override
  Set<SupaValue<CGemShareTokensTableCore, dynamic, dynamic>> get values => {
        CGemShareTokensTable.chestID(chestID),
        CGemShareTokensTable.gemID(gemID),
        if (token != null) CGemShareTokensTable.token(token!),
      };
}
