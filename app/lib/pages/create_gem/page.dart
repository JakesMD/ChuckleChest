import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/pages/_pages.dart';
import 'package:chuckle_chest/pages/edit_gem/bloc/gem_edit/bloc.dart';
import 'package:chuckle_chest/pages/edit_gem/bloc/gem_save/bloc.dart';
import 'package:chuckle_chest/shared/cubit/_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CCreateGemPage}
///
/// The page for creating a gem.
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
        BlocProvider<CGemEditBloc>(
          create: (context) => CGemEditBloc(
            gemRepository: context.read(),
            gem: null,
            chestID: context.read<CCurrentChestCubit>().state.id,
          ),
        ),
        BlocProvider<CGemSaveBloc>(
          create: (context) => CGemSaveBloc(gemRepository: context.read()),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) => const CEditGemPage(gem: null);
}
