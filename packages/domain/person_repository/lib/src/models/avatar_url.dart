import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:equatable/equatable.dart';

/// {@template CAvatarURL}
///
/// Represents a URL of an avatar for a person at a certain year.
///
/// {@endtemplate}
class CAvatarURL with EquatableMixin {
  /// {@macro CAvatarURL}
  const CAvatarURL({required this.year, required this.url});

  /// {@macro CAvatarURL}
  ///
  /// Converts a [CRawPersonAvatar] to a [CAvatarURL].
  CAvatarURL.fromRaw(CRawPersonAvatar raw)
      : year = raw.year,
        url = raw.imageURL;

  /// The year the avatar was taken.
  final int year;

  /// The URL of the avatar.
  final String url;

  @override
  List<Object?> get props => [year, url];
}
