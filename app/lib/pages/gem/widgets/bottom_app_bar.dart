import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/bloc/_bloc.dart';
import 'package:cpub/flutter_bloc.dart';
import 'package:flutter/material.dart';

/// {@template CGemPageBottomAppBar}
///
/// The bottom app bar for the gem page.
///
/// {@endtemplate}
class CGemPageBottomAppBar extends StatelessWidget {
  /// {@macro CGemPageBottomAppBar}
  const CGemPageBottomAppBar({required this.gemID, super.key});

  /// The unique identifier of the gem.
  final String gemID;

  void _onSharePressed(BuildContext context) {
    final box = context.findRenderObject() as RenderBox?;

    context.read<CGemShareBloc>().add(
          CGemShareTriggered(
            gemID: gemID,
            sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
            message: CAppL10n.of(context).gem_share_message,
            subject: CAppL10n.of(context).gem_share_subject,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () => _onSharePressed(context),
            icon: const Icon(Icons.share_rounded),
          ),
        ],
      ),
    );
  }
}
