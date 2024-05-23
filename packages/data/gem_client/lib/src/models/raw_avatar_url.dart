import 'package:cpub/equatable.dart';

/// {@template CRawAvatarURL}
///
/// The raw data that represents a URL of a photo of a person at a certain age.
///
/// {@endtemplate}
class CRawAvatarURL with EquatableMixin {
  /// {@macro CRawAvatarURL}
  const CRawAvatarURL({
    required this.url,
    required this.age,
  });

  /// {@macro CRawAvatarURL}
  ///
  /// Creates a [CRawAvatarURL] from a JSON object.
  CRawAvatarURL.fromJSON(Map<String, dynamic> json)
      : url = json['avatar_url'] as String,
        age = json['age'] as int;

  /// The URL of the photo of the person at that age.
  final String url;

  /// The age of the person at the time the photo was taken.
  final int age;

  @override
  List<Object?> get props => [url, age];
}
