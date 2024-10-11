import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/pages/_pages.dart';
import 'package:chuckle_chest/pages/edit_gem/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CCreateGemPage}
///
/// The page for creating a gem.
///
/// This page is a wrapper around the [CEditGemPage] with the [CGemEditCubit]
/// and [CGemSaveCubit] provided.
///
/// {@endtemplate}
@RoutePage()
class CCreateGemPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CCreateGemPage}
  const CCreateGemPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CGemEditCubit>(
          create: (context) => CGemEditCubit(
            gem: null,
            chestID: context.read<CCurrentChestCubit>().state.id,
          ),
        ),
        BlocProvider<CGemSaveCubit>(
          create: (context) => CGemSaveCubit(gemRepository: context.read()),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) => const CEditGemPage(initialGem: null);
}
