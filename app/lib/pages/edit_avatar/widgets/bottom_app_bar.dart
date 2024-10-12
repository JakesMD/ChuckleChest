import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_avatar/logic/_logic.dart';
import 'package:chuckle_chest/pages/edit_avatar/widgets/_widgets.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CEditAvatarBottomAppBar}
///
/// The bottom app bar on the edit avatar page that allows the user to pick a
/// photo and save the selected avatar.
///
/// {@endtemplate}
class CEditAvatarBottomAppBar extends StatelessWidget {
  /// {@macro CEditAvatarBottomAppBar}
  const CEditAvatarBottomAppBar({
    required this.personID,
    required this.avatarURL,
    required this.cropController,
    super.key,
  });

  /// The unique identifier of the person to edit the avatar for.
  final BigInt personID;

  /// The URL of the avatar to edit.
  final CAvatarURL avatarURL;

  /// The controller for the crop.
  final CropController cropController;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextButton.icon(
              onPressed: () => context.read<CAvatarPickCubit>().pickAvatar(),
              icon: const Icon(Icons.photo_library_rounded),
              label: Text(context.cAppL10n.editAvatarPage_pickPhotoButton),
            ),
          ),
          Expanded(
            child: CEditAvatarSaveButton(
              personID: personID,
              avatarURL: avatarURL,
              cropController: cropController,
            ),
          ),
        ],
      ),
    );
  }
}
