import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_person/bloc/person_update/cubit.dart';
import 'package:chuckle_chest/pages/edit_person/dialogs/edit_nickname.dart';
import 'package:chuckle_chest/shared/widgets/loading_indicator.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CNicknameTile}
///
/// A tile for displaying and editing a person's nickname.
///
/// {@endtemplate}
class CNicknameTile extends StatelessWidget {
  /// {@macro CNicknameTile}
  const CNicknameTile({required this.person, super.key});

  /// The person to display.
  final CPerson person;

  void _onPressed(BuildContext context) =>
      CEditNicknameDialog(person: person, cubit: context.read()).show(context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CPersonUpdateCubit, CPersonUpdateState>(
      builder: (context, state) => ListTile(
        leading: const Icon(Icons.person_rounded),
        title: Text(context.cAppL10n.editPersonPage_nicknameTile_title),
        subtitle: Text(person.nickname),
        trailing: state is CPersonUpdateInProgress
            ? const CBouncyBallLoadingIndicator()
            : const Icon(Icons.edit_rounded),
        onTap: () => _onPressed(context),
        enabled: state is! CPersonUpdateInProgress,
      ),
    );
  }
}
