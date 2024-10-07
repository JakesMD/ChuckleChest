import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CPeoplePage}
///
/// A tab on the home page page that displays a list of the chest people.
///
/// Pressing on a person will navigate to the edit person page.
///
/// Pressing the floadting action button (on the home page) will create a new
/// person and navigate to the edit person page.
///
/// {@endtemplate}
@RoutePage()
class CPeoplePage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CPeoplePage}
  const CPeoplePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    final people = context.read<CChestPeopleFetchCubit>().state.people
      ..sort((a, b) => b.dateOfBirth.compareTo(a.dateOfBirth));

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: people.length,
      itemBuilder: (context, index) {
        final person = people[index];

        return ListTile(
          minVerticalPadding: 16,
          leading: CAvatar.fromPerson(person: person, date: DateTime.now()),
          title: Text(person.nickname),
          subtitle: Text(
            context.cAppL10n
                .peoplePage_personItem_age(person.ageAtDate(DateTime.now())),
          ),
          trailing: const Icon(Icons.edit_rounded),
          onTap: () => context.router.push(CEditPersonRoute(person: person)),
        );
      },
    );
  }
}
