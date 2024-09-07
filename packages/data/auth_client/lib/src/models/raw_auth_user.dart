import 'package:cauth_client/cauth_client.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:supabase/supabase.dart';

/// {@template CRawAuthUser}
///
/// A raw representation of a user straight from the Supabase auth API.
///
/// {@endtemplate}
class CRawAuthUser with EquatableMixin {
  /// {@macro CRawAuthUser}
  const CRawAuthUser({
    required this.id,
    required this.username,
    required this.email,
    required this.chests,
  });

  /// {@macro CRawAuthUser}
  ///
  /// Creates a [CRawAuthUser] from a Supabase [Session].
  @internal
  factory CRawAuthUser.fromSupabaseSession(Session session) {
    final jwt = JWT.decode(session.accessToken).payload as Map<String, dynamic>;

    return CRawAuthUser(
      id: session.user.id,
      username: (session.user.userMetadata?['username'] ?? '') as String,
      email: session.user.email,
      chests: Map<String, dynamic>.from((jwt['chests'] ?? {}) as Map)
          .entries
          .map(CRawAuthUserChest.fromMapEntry)
          .toList(),
    );
  }

  /// The user's unique identifier.
  final String id;

  /// The user's username.
  final String username;

  /// The user's email address.
  final String? email;

  /// The chests the user is a part of.
  final List<CRawAuthUserChest> chests;

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        chests,
      ];

  @override
  String toString() =>
      '''CRawAuthUser(id: $id, username: $username, email: $email, chests: $chests)''';
}
