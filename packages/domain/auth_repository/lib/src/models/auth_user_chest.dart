import 'package:cauth_client/cauth_client.dart';
import 'package:ccore/ccore.dart';
import 'package:cpub/equatable.dart';
import 'package:cpub/meta.dart';

/// {@template CUserRole}
///
/// Represents a chest that a user is a part of.
///
/// {@endtemplate}
class CAuthUserChest with EquatableMixin {
  /// {@macro CAuthUserChest}
  const CAuthUserChest({
    required this.id,
    required this.name,
    required this.userRole,
  });

  /// Creates a [CAuthUserChest] from a [CRawAuthUserChest].
  @internal
  CAuthUserChest.fromRawUserChest(CRawAuthUserChest chest)
      : id = chest.id,
        name = chest.name,
        userRole = chest.userRole;

  /// The unique identifier for the chest.
  final String id;

  /// The name of the chest.
  final String name;

  /// The user's role in the chest.
  final CUserRole userRole;

  @override
  List<Object?> get props => [id, name, userRole];
}
