// Exceptions are unknown.
// ignore_for_file: avoid_catches_without_on_clauses

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
    required this.chestID,
  });

  /// {@macro CPerson}
  ///
  /// Converts a [CPeopleTableRecord] to a [CPerson].
  factory CPerson.fromRecord(CPeopleTableRecord record) {
    final avatars = <CAvatarURL>[];

    try {
      avatars
        ..addAll(record.avatars.map(CAvatarURL.fromRecord).toList())
        ..sort((a, b) => a.year.compareTo(b.year));
    } catch (e) {
      //
    }

    return CPerson(
      id: record.id,
      nickname: record.nickname,
      dateOfBirth: record.dateOfBirth,
      avatarURLs: avatars,
      chestID: record.chestID,
    );
  }

  /// The unique identifier of the person.
  final BigInt id;

  /// The nickname of the person.
  final String nickname;

  /// The date of birth of the person.
  final DateTime dateOfBirth;

  /// The URLs of the person's avatars.
  final List<CAvatarURL> avatarURLs;

  /// The ID of the chest the person belongs to.
  final String chestID;

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
  CAvatarURL? avatarURLForDate(DateTime? date) =>
      avatarURLs.cFirstWhereOrNull((a) => a.year == date?.year);

  /// Creates a copy of the person with the given fields updated.
  CPerson copyWith({String? nickname, DateTime? dateOfBirth}) {
    return CPerson(
      id: id,
      nickname: nickname ?? this.nickname,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      avatarURLs: avatarURLs,
      chestID: chestID,
    );
  }

  @override
  List<Object?> get props => [id, nickname, dateOfBirth, avatarURLs, chestID];
}
