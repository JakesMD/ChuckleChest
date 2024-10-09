import 'package:chuckle_chest/pages/edit_person/dialogs/crop_avatar.dart';
import 'package:chuckle_chest/pages/edit_person/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signed_spacing_flex/signed_spacing_flex.dart';

/// {@template CAvatarSection}
///
/// The section on the edit person page for displaying and editing a person's
/// avatars.
///
/// {@endtemplate}
class CAvatarSection extends StatelessWidget {
  /// {@macro CAvatarSection}
  const CAvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CAvatarPickCubit, CAvatarPickState>(
      listener: (context, state) => switch (state.status) {
        CRequestCubitStatus.initial => null,
        CRequestCubitStatus.inProgress => null,
        CRequestCubitStatus.failed => const CErrorSnackBar().show(context),
        CRequestCubitStatus.succeeded => state.image.evaluate(
            onAbsent: () {},
            onPresent: (image) => CCropAvatarDialog(
              image: image,
              person: context.read<CPersonUpdateCubit>().state.person,
              year: state.year!,
              cubit: context.read(),
            ).show(context),
          ),
      },
      child: BlocBuilder<CPersonUpdateCubit, CPersonUpdateState>(
        builder: (context, state) => Wrap(
          spacing: 16,
          runSpacing: 24,
          alignment: WrapAlignment.center,
          children: List.generate(
            DateTime.now().year + 1 - state.person.dateOfBirth.year,
            (index) => CEditableAvatar(
              person: state.person,
              date: DateTime(state.person.dateOfBirth.year + index),
            ),
          ),
        ),
      ),
    );
  }
}

class CEditableAvatar extends StatelessWidget {
  const CEditableAvatar({super.key, required this.person, required this.date});

  final CPerson person;

  final DateTime date;

  void _onAvatarPressed(BuildContext context, int year) =>
      context.read<CAvatarPickCubit>().pickAvatar(year: year);

  @override
  Widget build(BuildContext context) {
    return SignedSpacingColumn(
      spacing: 4,
      mainAxisSize: MainAxisSize.min,
      children: [
        CAvatar.fromPerson(
          person: person,
          date: date,
          diameter: 64,
          onPressed: () => _onAvatarPressed(context, date.year),
          icon: const Icon(Icons.add_photo_alternate_rounded),
        ),
        Text(date.year.toString()),
      ],
    );
  }
}
