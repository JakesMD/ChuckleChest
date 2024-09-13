import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/bloc/_bloc.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CPeoplePage}
///
/// A page that displays a list of the chest people to be edited.
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
    final people = context.read<CChestPeopleFetchBloc>().state.people;

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
