// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_roles.dart';

// **************************************************************************
// SupaTableGenerator
// **************************************************************************

// ignore_for_file: strict_raw_type
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

/// The base class that links all classes for [CUserRolesTable] together
/// to create full type safety.
base class CUserRolesTableCore extends SupaCore {}

/// {@template CUserRolesTableRecord}
///
/// Represents a record fetched from [CUserRolesTable].
///
/// {@endtemplate}
class CUserRolesTableRecord extends SupaRecord<CUserRolesTableCore> {
  /// {@macro CUserRolesTableRecord}
  const CUserRolesTableRecord(super.json);

  /// The ID of the chest the user is a member of.
  ///
  /// This will throw an exception if the column was not fetched.
  String get chestID => call(CUserRolesTable.chestID);

  /// The ID of the member.
  ///
  /// This will throw an exception if the column was not fetched.
  String get userID => call(CUserRolesTable.userID);

  /// The role of the user.
  ///
  /// This will throw an exception if the column was not fetched.
  CUserRole get role => call(CUserRolesTable.role);

  /// The chest the invitation is for.
  ///
  /// This will throw an exception if no joined columns were fetched.
  ///
  /// An InvalidType error here is often caused by a misspelling of the prefix in the @SupaTableJoinHere annotation.
  CChestsTableRecord get chest => referenceSingle(CUserRolesTable.chest)!;

  /// The user that the role is for.
  ///
  /// This will throw an exception if no joined columns were fetched.
  ///
  /// An InvalidType error here is often caused by a misspelling of the prefix in the @SupaTableJoinHere annotation.
  CUsersTableRecord get user => referenceSingle(CUserRolesTable.user)!;
}

/// {@template CUserRolesTableInsert}
///
/// Represents an insert operation on [CUserRolesTable].
///
/// {@endtemplate}
class CUserRolesTableInsert extends SupaInsert<CUserRolesTableCore> {
  /// {@macro CUserRolesTableInsert}
  const CUserRolesTableInsert({
    required this.chestID,
    required this.userID,
    required this.role,
  });

  /// The ID of the chest the user is a member of.
  final String chestID;

  /// The ID of the member.
  final String userID;

  /// The role of the user.
  final CUserRole role;

  @override
  Set<SupaValue<CUserRolesTableCore, dynamic, dynamic>> get values => {
        CUserRolesTable.chestID(chestID),
        CUserRolesTable.userID(userID),
        CUserRolesTable.role(role),
      };
}
