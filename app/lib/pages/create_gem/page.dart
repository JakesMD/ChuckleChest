import 'package:chuckle_chest/pages/_pages.dart';
import 'package:chuckle_chest/pages/edit_gem/bloc/gem_edit/bloc.dart';
import 'package:chuckle_chest/shared/bloc/_bloc.dart';
import 'package:chuckle_chest/shared/cubit/_cubit.dart';
import 'package:cpub/auto_route.dart';
import 'package:cpub/flutter_bloc.dart';
import 'package:flutter/material.dart';

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
          ),
        ),
        BlocProvider(
          create: (context) => CChestPeopleFetchBloc(
            personRepository: context.read(),
            chestID: context.read<CCurrentChestCubit>().state.id,
          ),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) => const CEditGemPage(isNewGem: true);
}
