import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/shared/bloc/_bloc.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CAvatar}
///
/// An avatar for a person.
///
/// {@endtemplate}
class CAvatar extends StatelessWidget {
  /// {@macro CAvatar}
  const CAvatar.fromPerson({
    required this.person,
    required this.date,
    super.key,
  })  : personID = null,
        people = null;

  /// {@macro CAvatar}
  const CAvatar.fromPersonID({
    required this.personID,
    required this.date,
    this.people,
    super.key,
  }) : person = null;

  /// The person to display.
  final CPerson? person;

  /// The ID of the person.
  final BigInt? personID;

  /// The people to select from.
  ///
  /// This is required if the [CChestPeopleFetchBloc] is not available (because
  /// the avatar is displayed within a dialog).
  final List<CPerson>? people;

  /// The date for the avatar.
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    String? url;

    if (person != null) {
      url = person?.avatarURLForDate(date);
    } else if (personID != null) {
      CPerson? person2;

      if (people != null) {
        person2 = people?.cFirstWhereOrNull((person) => person.id == personID);
      } else {
        person2 = context.read<CChestPeopleFetchBloc>().fetchPerson(personID!);
      }

      url = person2?.avatarURLForDate(date);
    }

    return CircleAvatar(
      foregroundImage: url != null ? NetworkImage(url) : null,
    );
  }
}
