import 'package:chuckle_chest/pages/edit_gem/logic/_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CSaveGemButton}
///
/// The action button on the edit gem page that saves the gem when pressed.
///
/// {@endtemplate}
class CSaveGemButton extends StatelessWidget {
  /// {@macro CSaveGemButton}
  const CSaveGemButton({super.key});

  void _onPressed(BuildContext context) {
    final editState = context.read<CGemEditCubit>().state;

    context
        .read<CGemSaveCubit>()
        .saveGem(gem: editState.gem, deletedLines: editState.deletedLines);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CGemSaveCubit>().state;

    return IconButton(
      onPressed: !state.inProgress ? () => _onPressed(context) : null,
      icon: const Icon(Icons.save_rounded),
    );
  }
}
