import 'package:cauth_repository/cauth_repository.dart';
import 'package:ccore/ccore.dart';

/// Provides extension methods on [CAuthUserChest].
extension CAuthUserChestX on CAuthUserChest {
  /// Returns `true` if the user is a viewer.
  bool get isUserViewer => userRole == CUserRole.viewer;

  /// Returns `true` if the user is a collaborator.
  bool get isUserCollaborator => userRole == CUserRole.collaborator;

  //// Returns `true` if the user is the chest owner.
  bool get isUserOwner => userRole == CUserRole.owner;

  /// Returns `true` if the user is a collaborator or the owner.
  bool get isUserManager => !isUserViewer;
}
