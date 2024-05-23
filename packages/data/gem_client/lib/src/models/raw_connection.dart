import 'package:cgem_client/cgem_client.dart';
import 'package:cpub/equatable.dart';

/// {@template CRawConnection}
///
/// The raw data that represents a friend or family member.
///
/// {@endtemplate}
class CRawConnection with EquatableMixin {
  /// {@macro CRawConnection}
  const CRawConnection({
    required this.nickname,
    required this.dateOfBirth,
    required this.avatarURLs,
  });

  /// {@macro CRawConnection}
  ///
  /// Creates a [CRawConnection] from a JSON object.
  CRawConnection.fromJSON(Map<String, dynamic> json)
      : nickname = json['nickname'] as String,
        dateOfBirth = DateTime.parse(json['date_of_birth'] as String),
        avatarURLs = List<Map<String, dynamic>>.from(
          (json['connection_avatar_urls'] ?? []) as List<dynamic>,
        ).map(CRawAvatarURL.fromJSON).toList();

  /// The nickname of the person who made the connection.
  final String nickname;

  /// The date of birth of the person who made the connection.
  final DateTime dateOfBirth;

  /// The URLs of the photos of the person at different ages.
  final List<CRawAvatarURL> avatarURLs;

  @override
  List<Object?> get props => [nickname, dateOfBirth, avatarURLs];
}
