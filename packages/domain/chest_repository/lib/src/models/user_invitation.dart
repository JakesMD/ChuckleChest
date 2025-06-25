import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:equatable/equatable.dart';

/// {@template CUserInvitation}
///
/// Represents an invitation for a user to join a chest.
///
/// {@endtemplate}
class CUserInvitation with EquatableMixin {
  /// {@macro CUserInvitation}
  const CUserInvitation({
    required this.chestID,
    required this.assignedRole,
    required this.chestName,
  });

  /// {@macro CUserInvitation}
  ///
  /// Creates a new [CUserInvitation] from the given [raw].
  CUserInvitation.fromRecord(CRawInvitation raw)
      : chestID = raw.chest.id,
        assignedRole = raw.assignedRole,
        chestName = raw.chest.name;

  /// The ID of the chest the user is invited to.
  final String chestID;

  /// The role the user is assigned.
  final CUserRole assignedRole;

  /// The name of the chest the user is invited to.
  final String chestName;

  @override
  List<Object?> get props => [chestID, assignedRole, chestName];
}
