import 'package:ccore/ccore.dart';
import 'package:equatable/equatable.dart';

/// {@template CUserRole}
///
/// Represents a chest that a user is a part of.
///
/// {@endtemplate}
class CRawAuthUserChest with EquatableMixin {
  /// {@macro CRawAuthUserChest}
  const CRawAuthUserChest({
    required this.id,
    required this.name,
    required this.userRole,
  });

  /// Creates a [CRawAuthUserChest] from a map entry.
  factory CRawAuthUserChest.fromMapEntry(MapEntry<String, dynamic> entry) {
    final data = entry.value as Map<String, dynamic>;
    return CRawAuthUserChest(
      id: entry.key,
      name: data['name'] as String,
      userRole: CUserRole.parse(data['role'] as String),
    );
  }

  /// The unique identifier for the chest.
  final String id;

  /// The name of the chest.
  final String name;

  /// The user's role in the chest.
  final CUserRole userRole;

  @override
  List<Object?> get props => [id, name, userRole];
}
