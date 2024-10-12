import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_avatar/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CEditAvatarSaveButton}
///
/// The button on the edit avatar page that allows the user to save the
/// selected avatar.
///
/// {@endtemplate}
class CEditAvatarSaveButton extends StatelessWidget {
  /// {@macro CEditAvatarSaveButton}
  const CEditAvatarSaveButton({
    required this.personID,
    required this.avatarURL,
    required this.cropController,
    super.key,
  });

  /// The unique identifier of the person to update the avatar for.
  final BigInt personID;

  /// The avatar URL to update.
  final CAvatarURL avatarURL;

  /// The controller for the crop.
  final CropController cropController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CAvatarPickCubit, CAvatarPickState>(
      builder: (context, pickState) =>
          BlocBuilder<CAvatarUpdateCubit, CAvatarUpdateState>(
        builder: (context, saveState) => ElevatedButton.icon(
          onPressed: saveState.status != CRequestCubitStatus.inProgress
              ? pickState.status == CRequestCubitStatus.succeeded
                  ? pickState.image.evaluate(
                      onAbsent: () => null,
                      onPresent: (image) => cropController.crop,
                    )
                  : null
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: context.cColorScheme.primary,
            foregroundColor: context.cColorScheme.onPrimary,
          ),
          icon: const Icon(Icons.save_rounded),
          label: saveState.status != CRequestCubitStatus.inProgress
              ? Text(context.cAppL10n.save)
              : const CCradleLoadingIndicator(),
        ),
      ),
    );
  }
}
