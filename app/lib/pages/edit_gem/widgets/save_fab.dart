import 'package:chuckle_chest/pages/edit_gem/bloc/gem_edit/bloc.dart';
import 'package:chuckle_chest/pages/edit_gem/bloc/gem_save/bloc.dart';
import 'package:chuckle_chest/shared/widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CSaveGemFAB}
///
/// A floating action button for saving a gem.
///
/// {@endtemplate}
class CSaveGemFAB extends StatelessWidget {
  /// {@macro CSaveGemFAB}
  const CSaveGemFAB({super.key});

  void _onPressed(BuildContext context, CGemSaveBloc bloc) {
    final gemEditBloc = context.read<CGemEditBloc>();
    bloc.add(
      CGemSaveSubmitted(
        gem: gemEditBloc.state.gem,
        deletedLines: gemEditBloc.state.deletedLines,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CLoadingButton<CGemSaveBloc, CGemSaveState>(
      isLoading: (state) => true, //state is CGemSaveInProgress,
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
