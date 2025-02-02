import 'package:chuckle_chest/pages/edit_avatar/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CEditAvatarPageCrop}
///
/// The crop widget on the edit avatar page that allows the user to crop the
/// selected avatar.
///
/// {@endtemplate}
class CEditAvatarPageCrop extends StatelessWidget {
  /// {@macro CEditAvatarPageCrop}
  const CEditAvatarPageCrop({
    required this.cropController,
    required this.personID,
    required this.avatarURL,
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
    return BlocBuilder<CAvatarPickCubit, CAvatarPickState>(
      builder: (context, state) => switch (state.status) {
        CRequestCubitStatus.initial => const SizedBox(),
        CRequestCubitStatus.inProgress => ColoredBox(
            color: Colors.white.withValues(alpha: 0.75),
            child: const Center(child: CCradleLoadingIndicator()),
          ),
        CRequestCubitStatus.failed => const SizedBox(),
        CRequestCubitStatus.succeeded => state.image.resolve(
            onAbsent: () => const SizedBox(),
            onPresent: (image) => Padding(
              padding: const EdgeInsets.all(16),
              child: Crop(
                controller: cropController,
                image: image,
                withCircleUi: true,
                onCropped: (cropped) =>
                    context.read<CAvatarUpdateCubit>().updateAvatarForYear(
                          personID: personID,
                          image: cropped,
                          year: avatarURL.year,
                          chestID: context.read<CCurrentChestCubit>().state.id,
                        ),
              ),
            ),
          ),
      },
    );
  }
}
