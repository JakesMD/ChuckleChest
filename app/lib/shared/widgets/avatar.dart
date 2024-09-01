import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/shared/bloc/_bloc.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:cpub/flutter_bloc.dart';
import 'package:flutter/material.dart';

/// {@template CAvatar}
///
/// An avatar for a person.
///
/// {@endtemplate}
class CAvatar extends StatelessWidget {
  /// {@macro CAvatar}
  const CAvatar({
    this.personID,
    this.people,
    this.age,
    this.date,
    super.key,
  });

  /// The ID of the person.
  final BigInt? personID;

  /// The people to select from.
  ///
  /// This is required if the [CChestPeopleFetchBloc] is not available (because
  /// the avatar is displayed within a dialog).
  final List<CPerson>? people;

  /// The age of the person.
  ///
  /// Use [date] if the age is not known but the date is.
  final int? age;

  /// The date for the avatar.
  ///
  /// Use [age] if the age is known but the date is not.
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    late String? url;

    if (personID != null) {
      late CPerson? person;

      if (people != null) {
        person = people?.cFirstWhereOrNull((person) => person.id == personID);
      } else {
        person = context.read<CChestPeopleFetchBloc>().fetchPerson(personID!);
      }

      url = age != null
          ? person?.avatarURLForAge(age)
          : person?.avatarURLForDate(date);
    } else {
      url = null;
    }

    return CircleAvatar(
      foregroundImage: url != null ? NetworkImage(url) : null,
    );
  }
}
