import 'package:cauth_client/cauth_client.dart';
import 'package:cauth_repository/src/models/auth_user_chest.dart';
import 'package:cpub/equatable.dart';
import 'package:cpub/meta.dart';

/// {@template CAuthUser}
///
/// Represents a user currently signed in.
///
/// {@endtemplate}
class CAuthUser with EquatableMixin {
  /// {@macro CAuthUser}
  const CAuthUser({
    required this.id,
    required this.username,
    required this.email,
    required this.chests,
  });

  /// {@macro CAuthUser}
  ///
  /// Creates a [CAuthUser] from a [CRawAuthUser].
  @internal
  CAuthUser.fromRawUser(CRawAuthUser user)
      : id = user.id,
        username = user.username,
        email = user.email!,
        chests = user.chests.map(CAuthUserChest.fromRawUserChest).toList();

  /// The user's unique identifier.
  final String id;

  /// The user's username.
  final String username;

  /// The user's email address.
  final String email;

  /// The chests that the user is a part of.
  final List<CAuthUserChest> chests;

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        chests,
      ];
}
