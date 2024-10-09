import 'dart:typed_data';

import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_person/logic/_logic.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CNicknameTile}
///
/// The dialog on the edit person page for cropping a person's avatar and
/// uploading it.
///
/// {@endtemplate}
class CCropAvatarDialog extends StatelessWidget with CDialogMixin {
  /// {@macro CCropAvatarDialog}
  CCropAvatarDialog({
    required this.image,
    required this.person,
    required this.year,
    required this.cubit,
    super.key,
  });

  /// The image that is being cropped.
  final Uint8List image;

  /// The person whose avatar is being cropped.
  final CPerson person;

  /// The year for which the avatar is being cropped.
  final int year;

  /// The cubit that will update the person's avatar.
  ///
  /// Because the dialog is not a part of the page's context, the cubit is
  /// passed in as a parameter.
  final CAvatarUpdateCubit cubit;

  final controller = CropController();

  void _onOkPressed(BuildContext context) => controller.crop();

  void _onCropped(BuildContext context, Uint8List image) {
    cubit.updateAvatarForYear(image: image, person: person, year: year);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: AlertDialog(
        title: Text(context.cAppL10n.editPersonPage_editNicknameDialog_title),
        content: SizedBox(
          width: 300,
          height: 300,
          child: Crop(
            controller: controller,
            image: image,
            onCropped: (image) => _onCropped(context, image),
            aspectRatio: 1,
            withCircleUi: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.cAppL10n.cancel),
          ),
          TextButton(
            onPressed: () => _onOkPressed(context),
            child: Text(context.cAppL10n.save),
          ),
        ],
      ),
    );
  }
}
