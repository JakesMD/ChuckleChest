import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:equatable/equatable.dart';

/// {@template CAvatarURL}
///
/// Represents a URL of an avatar for a person at a certain year.
///
/// {@endtemplate}
class CAvatarURL with EquatableMixin {
  /// {@macro CAvatarURL}
  const CAvatarURL({
    required this.year,
    required this.url,
  });

  /// {@macro CAvatarURL}
  ///
  /// Converts a [CAvatarsTableRecord] to a [CAvatarURL].
  CAvatarURL.fromRecord(CAvatarsTableRecord record)
      : year = record.year,
        url = record.imageURL;

  /// The year the avatar was taken.
  final int year;

  /// The URL of the avatar.
  final String url;

  @override
  List<Object?> get props => [year, url];
}
