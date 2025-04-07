import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_person/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CDateOfBirthTile}
///
/// The tile on the edit person page for displaying and editing a person's date
/// of birth.
///
/// {@endtemplate}
class CDateOfBirthTile extends StatelessWidget {
  /// {@macro CDateOfBirthTile}
  const CDateOfBirthTile({super.key});

  Future<void> _onPressed(BuildContext context) async {
    final cubit = context.read<CPersonUpdateCubit>();

    final date = await showDatePicker(
      confirmText: context.cAppL10n.save,
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: cubit.state.person.dateOfBirth,
    );

    if (date != null) await cubit.updateDateOfBirth(dateOfBirth: date);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CPersonUpdateCubit>().state;

    return ListTile(
      minVerticalPadding: 24,
      leading: const Icon(Icons.today_rounded),
      title: Text(context.cAppL10n.editPersonPage_dateOfBirthTile_title),
      subtitle: Text(state.person.dateOfBirth.cLocalize(context)),
      trailing: state.status == CRequestCubitStatus.inProgress
          ? const CBouncyBallLoadingIndicator()
          : const Icon(Icons.edit_rounded),
      onTap: () => _onPressed(context),
      enabled: state.status != CRequestCubitStatus.inProgress,
    );
  }
}
