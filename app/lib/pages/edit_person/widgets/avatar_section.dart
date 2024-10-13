import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/router.dart';
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
    return BlocBuilder<CPersonUpdateCubit, CPersonUpdateState>(
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
        ).reversed.toList(),
      ),
    );
  }
}

/// {@template CEditableAvatar}
///
/// An avatar in the avatar section on the edit person page that allows the user
/// to edit the avatar.
///
/// {@endtemplate}
class CEditableAvatar extends StatelessWidget {
  /// {@macro CEditableAvatar}
  const CEditableAvatar({
    required this.person,
    required this.date,
    super.key,
  });

  /// The person to edit the avatar for.
  final CPerson person;

  /// The date of the avatar.
  final DateTime date;

  Future<void> _onAvatarPressed(BuildContext context, int year) async {
    final updateCubit = context.read<CPersonUpdateCubit>();
    final result = await context.router.push(
      CEditAvatarRoute(
        personID: person.id,
        avatarURL:
            person.avatarURLForDate(date) ?? CAvatarURL(year: year, url: ''),
      ),
    );
    if (result != null) {
      updateCubit.updateAvatar(avatarURL: result as CAvatarURL);
    }
  }

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
