import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cpub/equatable.dart';

/// {@template CAvatarURL}
///
/// Represents a URL of an avatar for a person at a certain age.
///
/// {@endtemplate}
class CAvatarURL with EquatableMixin {
  /// {@macro CAvatarURL}
  const CAvatarURL({
    required this.age,
    required this.url,
  });

  /// {@macro CAvatarURL}
  ///
  /// Converts a [CAvatarURLsTableRecord] to a [CAvatarURL].
  CAvatarURL.fromRecord(CAvatarURLsTableRecord record)
      : age = record.age,
        url = record.url;

  /// The age of the person when the avatar was taken.
  final int age;

  /// The URL of the avatar.
  final String url;

  @override
  List<Object?> get props => [age, url];
}
