import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:equatable/equatable.dart';

/// {@template CChestInvitation}
///
/// Represents an invitation in a chest.
///
/// {@endtemplate}
class CChestInvitation with EquatableMixin {
  /// {@macro CChestInvitation}
  const CChestInvitation({
    required this.chestID,
    required this.email,
    required this.assignedRole,
  });

  /// {@macro CChestInvitation}
  ///
  /// Creates a new [CChestInvitation] from the given [raw].
  CChestInvitation.fromRaw(CRawInvitation raw)
      : chestID = raw.chest.id,
        email = raw.email,
        assignedRole = raw.assignedRole;

  /// The ID of the chest the invitation is for.
  final String chestID;

  /// The email of the user invited to the chest.
  final String email;

  /// The role the user is assigned.
  final CUserRole assignedRole;

  @override
  List<Object?> get props => [chestID, email, assignedRole];
}
