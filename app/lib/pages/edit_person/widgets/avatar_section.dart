import 'package:chuckle_chest/pages/edit_person/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
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
    return BlocBuilder<CPersonUpdateCubit, CPersonUpdateState>(
      builder: (context, state) => Wrap(
        spacing: 16,
        runSpacing: 24,
        alignment: WrapAlignment.center,
        children: List.generate(
          DateTime.now().year - state.person.dateOfBirth.year,
          (index) => SignedSpacingColumn(
            spacing: 4,
            mainAxisSize: MainAxisSize.min,
            children: [
              CAvatar.fromPerson(
                person: state.person,
                date: DateTime(state.person.dateOfBirth.year + index),
                diameter: 64,
                onPressed: () {},
                icon: const Icon(Icons.add_photo_alternate_rounded),
              ),
              Text((state.person.dateOfBirth.year + index).toString()),
            ],
          ),
        ),
      ),
    );
  }
}
