import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_person/bloc/person_update/cubit.dart';
import 'package:chuckle_chest/shared/widgets/loading_indicator.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CDateOfBirthTile}
///
/// A tile for displaying and editing a person's date of birth.
///
/// {@endtemplate}
class CDateOfBirthTile extends StatelessWidget {
  /// {@macro CDateOfBirthTile}
  const CDateOfBirthTile({required this.person, super.key});

  /// The person to change.
  final CPerson person;

  Future<void> _onPressed(BuildContext context, CPerson person) async {
    final date = await showDatePicker(
      confirmText: context.cAppL10n.save,
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: person.dateOfBirth,
    );

    if (context.mounted && date != null) {
      await context.read<CPersonUpdateCubit>().updateDateOfBirth(person, date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CPersonUpdateCubit, CPersonUpdateState>(
      builder: (context, state) => ListTile(
        leading: const Icon(Icons.today_rounded),
        title: Text(context.cAppL10n.editPersonPage_dateOfBirthTile_title),
        subtitle: Text(person.dateOfBirth.cLocalize(context)),
        trailing: state is CPersonUpdateInProgress
            ? const CBouncyBallLoadingIndicator()
            : const Icon(Icons.edit_rounded),
        onTap: () => _onPressed(context, person),
        enabled: state is! CPersonUpdateInProgress,
      ),
    );
  }
}
