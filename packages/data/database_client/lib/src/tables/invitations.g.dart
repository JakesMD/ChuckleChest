// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitations.dart';

// **************************************************************************
// SupaTableGenerator
// **************************************************************************

// ignore_for_file: strict_raw_type
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

/// The base class that links all classes for [CInvitationsTable] together
/// to create full type safety.
base class CInvitationsTableCore extends SupaCore {}

/// {@template CInvitationsTableRecord}
///
/// Represents a record fetched from [CInvitationsTable].
///
/// {@endtemplate}
class CInvitationsTableRecord extends SupaRecord<CInvitationsTableCore> {
  /// {@macro CInvitationsTableRecord}
  const CInvitationsTableRecord(super.json);

  /// The email of the person invited.
  ///
  /// This will throw an exception if the column was not fetched.
  String get email => call(CInvitationsTable.email);

  /// The assigned role of the person invited.
  ///
  /// This will throw an exception if the column was not fetched.
  CUserRole get assignedRole => call(CInvitationsTable.assignedRole);

  /// The ID of the chest the invitation is for.
  ///
  /// This will throw an exception if the column was not fetched.
  String get chestID => call(CInvitationsTable.chestID);

  /// The chest the invitation is for.
  ///
  /// This will throw an exception if no joined columns were fetched.
  ///
  /// An InvalidType error here is often caused by a misspelling of the prefix in the @SupaTableJoinHere annotation.
  CChestsTableRecord get chest => referenceSingle(CInvitationsTable.chest)!;
}

/// {@template CInvitationsTableInsert}
///
/// Represents an insert operation on [CInvitationsTable].
///
/// {@endtemplate}
class CInvitationsTableInsert extends SupaInsert<CInvitationsTableCore> {
  /// {@macro CInvitationsTableInsert}
  const CInvitationsTableInsert({
    required this.email,
    required this.assignedRole,
    required this.chestID,
  });

  /// The email of the person invited.
  final String email;

  /// The assigned role of the person invited.
  final CUserRole assignedRole;

  /// The ID of the chest the invitation is for.
  final String chestID;

  @override
  Set<SupaValue<CInvitationsTableCore, dynamic, dynamic>> get values => {
        CInvitationsTable.email(email),
        CInvitationsTable.assignedRole(assignedRole),
        CInvitationsTable.chestID(chestID),
      };
}
