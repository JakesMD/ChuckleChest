// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// SupaTableGenerator
// **************************************************************************

// ignore_for_file: strict_raw_type
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

/// The base class that links all classes for [CUsersTable] together
/// to create full type safety.
base class CUsersTableCore extends SupaCore {}

/// {@template CUsersTableRecord}
///
/// Represents a record fetched from [CUsersTable].
///
/// {@endtemplate}
class CUsersTableRecord extends SupaRecord<CUsersTableCore> {
  /// {@macro CUsersTableRecord}
  const CUsersTableRecord(super.json);

  /// The ID of the user.
  ///
  /// This will throw an exception if the column was not fetched.
  String get id => call(CUsersTable.id);

  /// The username of the user.
  ///
  /// This will throw an exception if the column was not fetched.
  String? get username => call(CUsersTable.username);
}

/// {@template CUsersTableInsert}
///
/// Represents an insert operation on [CUsersTable].
///
/// {@endtemplate}
class CUsersTableInsert extends SupaInsert<CUsersTableCore> {
  /// {@macro CUsersTableInsert}
  const CUsersTableInsert({
    required this.id,
    this.username,
  });

  /// The ID of the user.
  final String id;

  /// The username of the user.
  final String? username;

  @override
  Set<SupaValue<CUsersTableCore, dynamic, dynamic>> get values => {
        CUsersTable.id(id),
        if (username != null) CUsersTable.username(username),
      };
}
