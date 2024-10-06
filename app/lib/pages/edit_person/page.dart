import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_person/logic/_logic.dart';
import 'package:chuckle_chest/pages/edit_person/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CEditPersonPage}
///
/// The page that allows the user to edit a person's nickname, date of birth and
/// avatars.
///
/// {@endtemplate}
@RoutePage()
class CEditPersonPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CEditPersonPage}
  const CEditPersonPage({required this.person, super.key});

  /// The person to edit.
  final CPerson person;

  void _onPopped(BuildContext context) {
    final hasPersonChanged = context.read<CPersonUpdateCubit>().state.status !=
        CRequestCubitStatus.initial;

    if (hasPersonChanged) {
      context.router.replaceAll([CChestRoute(chestID: person.chestID)]);
    } else {
      context.router.maybePop();
    }
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CPersonUpdateCubit(
            personRepository: context.read(),
            person: person,
          ),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CPersonUpdateCubit, CPersonUpdateState>(
            listener: (context, state) => const CErrorSnackBar().show(context),
            listenWhen: (_, state) =>
                state.status == CRequestCubitStatus.failed,
          ),
        ],
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, ___) async => _onPopped(context),
      child: Scaffold(
        appBar: CAppBar(
          context: context,
          title: Text(context.cAppL10n.editPersonPage_title),
        ),
        body: ListView(
          padding: const EdgeInsets.only(bottom: 16),
          children: [
            MaterialBanner(
              content: Text(context.cAppL10n.editPersonPage_banner_message),
              leading: const Icon(Icons.info_rounded),
              actions: [Container()],
            ),
            const SizedBox(height: 16),
            const CNicknameTile(),
            const CDateOfBirthTile(),
            const SizedBox(height: 48),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CAvatarSection(),
            ),
          ],
        ),
      ),
    );
  }
}
