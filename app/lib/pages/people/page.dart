import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/home/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:cperson_repository/cperson_repository.dart';
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

  Future<void> _onTileTapped(BuildContext context, CPerson person) async {
    final cubit = context.read<CChestPeopleFetchCubit>();
    final result = await context.router.push(CEditPersonRoute(person: person));

    if (result != null) cubit.updatePerson(person: result as CPerson);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CChestPeopleFetchCubit>().state;

    return Scaffold(
      appBar: AppBar(title: const CHomePageAppBarTitle()),
      body: CResponsiveListView.builder(
        padding: const EdgeInsets.only(top: 16, bottom: 80),
        items: state.people,
        itemBuilder: (context, person) => ListTile(
          minVerticalPadding: 16,
          leading: CAvatar.fromPerson(person: person, date: DateTime.now()),
          title: Text(person.nickname),
          subtitle: Text(
            context.cAppL10n
                .peoplePage_personItem_age(person.ageAtDate(DateTime.now())),
          ),
          trailing: const Icon(Icons.edit_rounded),
          onTap: () => _onTileTapped(context, person),
        ),
      ),
    );
  }
}
