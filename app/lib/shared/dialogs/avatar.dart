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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              clipBehavior: Clip.hardEdge,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: imageURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
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
