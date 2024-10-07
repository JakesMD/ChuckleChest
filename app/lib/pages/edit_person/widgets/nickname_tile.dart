import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_person/dialogs/edit_nickname.dart';
import 'package:chuckle_chest/pages/edit_person/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CNicknameTile}
///
/// The tile on the edit person page for displaying and editing a person's
/// nickname.
///
/// {@endtemplate}
class CNicknameTile extends StatelessWidget {
  /// {@macro CNicknameTile}
  const CNicknameTile({super.key});

  void _onPressed(BuildContext context) =>
      CEditNicknameDialog(cubit: context.read()).show(context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CPersonUpdateCubit, CPersonUpdateState>(
      builder: (context, state) => ListTile(
        leading: const Icon(Icons.person_rounded),
        title: Text(context.cAppL10n.editPersonPage_nicknameTile_title),
        subtitle: Text(state.person.nickname),
        trailing: state.status == CRequestCubitStatus.inProgress
            ? const CBouncyBallLoadingIndicator()
            : const Icon(Icons.edit_rounded),
        onTap: () => _onPressed(context),
        enabled: state.status != CRequestCubitStatus.inProgress,
      ),
    );
  }
}
