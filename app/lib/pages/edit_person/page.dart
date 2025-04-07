import 'package:auto_route/auto_route.dart';
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
/// When this page is popped, it will return the updated person.
///
/// {@endtemplate}
@RoutePage()
class CEditPersonPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CEditPersonPage}
  const CEditPersonPage({
    required this.person,
    this.isPersonNew = false,
    super.key,
  });

  /// The person to edit.
  final CPerson person;

  /// Whether the person is new.
  ///
  /// If true, the session will be refreshed when the page is popped.
  final bool isPersonNew;

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

  void _onBackPressed(BuildContext context) =>
      context.router.maybePop(context.read<CPersonUpdateCubit>().state.person);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => _onBackPressed(context)),
        title: Text(context.cAppL10n.editPersonPage_title),
        bottom: CAppBarLoadingIndicator(
          listeners: [
            CLoadingListener<CPersonUpdateCubit, CPersonUpdateState>(),
          ],
        ),
      ),
      body: const Column(
        children: [
          CChangesPropagationBanner(),
          Expanded(
            child: CResponsiveListView(
              padding: EdgeInsets.symmetric(vertical: 16),
              children: [
                CNicknameTile(),
                CDateOfBirthTile(),
                SizedBox(height: 48),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: CAvatarSection(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
