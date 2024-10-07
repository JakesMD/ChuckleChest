import 'package:chuckle_chest/pages/edit_gem/logic/_logic.dart';
import 'package:chuckle_chest/shared/logic/_logic.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CSaveGemFAB}
///
/// The floating action button on the edit gem page that saves the gem when
/// pressed.
///
/// {@endtemplate}
class CSaveGemFAB extends StatelessWidget {
  /// {@macro CSaveGemFAB}
  const CSaveGemFAB({super.key});

  void _onPressed(BuildContext context, CGemSaveCubit saveCubit) {
    final editState = context.read<CGemEditCubit>().state;

    saveCubit.saveGem(gem: editState.gem, deletedLines: editState.deletedLines);
  }

  @override
  Widget build(BuildContext context) {
    return CLoadingButton<CGemSaveCubit, CGemSaveState>(
      isLoading: (state) => state.status == CRequestCubitStatus.inProgress,
      isSmall: true,
      onPressed: _onPressed,
      child: const Icon(Icons.save_rounded),
      builder: (context, child, onPressed) => FloatingActionButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
