import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

/// {@template CAvatarDialog}
///
/// A dialog is opened when an avatar is tapped and displays the avatar in a
/// larger format.
///
/// {@endtemplate}
class CAvatarDialog extends StatelessWidget with CDialogMixin {
  /// {@macro CAvatarDialog}
  const CAvatarDialog({
    required this.nickname,
    required this.year,
    required this.imageURL,
    super.key,
  });

  /// The nickname of the person the avatar corresponds to.
  final String nickname;

  /// The year the avatar corresponds to.
  final int year;

  /// The URL of the avatar to display.
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('$nickname - $year'),
      content: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: imageURL,
        height: 200,
        width: 200,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.cAppL10n.close),
        ),
      ],
    );
  }
}
