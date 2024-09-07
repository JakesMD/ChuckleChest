import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cperson_repository/src/models/_models.dart';
import 'package:equatable/equatable.dart';

/// {@template CPerson}
///
/// Represents a person in from a quote.
///
/// {@endtemplate}
class CPerson with EquatableMixin {
  /// {@macro CPerson}
  const CPerson({
    required this.id,
    required this.nickname,
    required this.dateOfBirth,
    required this.avatarURLs,
  });

  /// {@macro CPerson}
  ///
  /// Converts a [CPeopleTableRecord] to a [CPerson].
  CPerson.fromRecord(CPeopleTableRecord record)
      : id = record.id,
        nickname = record.nickname,
        dateOfBirth = record.dateOfBirth,
        avatarURLs = record.avatarURLs.map(CAvatarURL.fromRecord).toList()
          ..sort((a, b) => a.year.compareTo(b.year));

  /// The unique identifier of the person.
  final BigInt id;

  /// The nickname of the person.
  final String nickname;

  /// The date of birth of the person.
  final DateTime dateOfBirth;

  /// The URLs of the person's avatars.
  final List<CAvatarURL> avatarURLs;

  /// The age of the person at the given date.
  int ageAtDate(DateTime date) {
    var age = date.year - dateOfBirth.year;

    if (date.month < dateOfBirth.month ||
        (date.month == dateOfBirth.month && date.day < dateOfBirth.day)) {
      age--;
    }
    return age;
  }

  /// The URL of the person's avatar for the given date.
  String? avatarURLForDate(DateTime? date) =>
      avatarURLs.cFirstWhereOrNull((a) => a.year == date?.year)?.url;

  @override
  List<Object?> get props => [id, nickname, dateOfBirth, avatarURLs];
}
