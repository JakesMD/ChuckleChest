import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_person/bloc/person_stream/cubit.dart';
import 'package:chuckle_chest/pages/edit_person/bloc/person_update/cubit.dart';
import 'package:chuckle_chest/pages/edit_person/widgets/date_of_birth_tile.dart';
import 'package:chuckle_chest/pages/edit_person/widgets/nickname_tile.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signed_spacing_flex/signed_spacing_flex.dart';

/// {@template CEditPersonPage}
///
/// The page that allows the user to edit person data.
///
/// {@endtemplate}
@RoutePage()
class CEditPersonPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CEditPersonPage}
  const CEditPersonPage({
    required this.personID,
    super.key,
  });

  /// The ID of the person to edit.
  final BigInt personID;

  void _onPopped(BuildContext context, CPersonStreamState state) {
    final hasPersonChanged = state is CPersonStreamSuccess &&
        context.read<CPersonUpdateCubit>().state is CPersonUpdateSuccess;

    if (hasPersonChanged) {
      context.router.replaceAll([CChestRoute(chestID: state.person.chestID)]);
    } else {
      context.router.maybePop();
    }
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CPersonStreamCubit(
            personRepository: context.read(),
            personID: personID,
          ),
        ),
        BlocProvider(
          create: (context) =>
              CPersonUpdateCubit(personRepository: context.read()),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CPersonStreamCubit, CPersonStreamState>(
      builder: (context, state) => PopScope(
        onPopInvokedWithResult: (_, ___) async => _onPopped(context, state),
        child: Scaffold(
          appBar: CAppBar(
            context: context,
            title: Text(context.cAppL10n.editPersonPage_title),
          ),
          body: switch (state) {
            CPersonStreamInitial() =>
              const Center(child: CCradleLoadingIndicator()),
            CPersonStreamFailure() =>
              const Center(child: Icon(Icons.error_rounded)),
            CPersonStreamSuccess(person: final person) => ListView(
                padding: const EdgeInsets.only(bottom: 16),
                children: [
                  MaterialBanner(
                    content: Text(
                      context.cAppL10n.editPersonPage_banner_message,
                    ),
                    leading: const Icon(Icons.info_rounded),
                    actions: [Container()],
                  ),
                  const SizedBox(height: 16),
                  CNicknameTile(person: person),
                  CDateOfBirthTile(person: person),
                  const SizedBox(height: 48),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 24,
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        DateTime.now().year - person.dateOfBirth.year,
                        (index) {
                          return SignedSpacingColumn(
                            spacing: 4,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CAvatar.fromPerson(
                                person: person,
                                date: DateTime(person.dateOfBirth.year + index),
                                diameter: 64,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.add_photo_alternate_rounded,
                                ),
                              ),
                              Text(
                                (person.dateOfBirth.year + index).toString(),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
          },
        ),
      ),
    );
  }
}
