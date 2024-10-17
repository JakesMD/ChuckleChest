import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:equatable/equatable.dart';

/// {@template CMember}
///
/// Represents an invitation in a chest.
///
/// {@endtemplate}
class CMember with EquatableMixin {
  /// {@macro CMember}
  const CMember({
    required this.chestID,
    required this.userID,
    required this.username,
    required this.role,
  });

  /// {@macro CMember}
  ///
  /// Creates a new [CMember] from the given [record].
  CMember.fromRecord(CUserRolesTableRecord record)
      : chestID = record.chestID,
        userID = record.user.id,
        username = record.user.username,
        role = record.role;

  /// The ID of the chest the user is a member of.
  final String chestID;

  /// The ID of the user.
  final String userID;

  /// The username of the user.
  final String? username;

  /// The role of the user in the chest.
  final CUserRole role;

  @override
  List<Object?> get props => [chestID, userID, username, role];
}
