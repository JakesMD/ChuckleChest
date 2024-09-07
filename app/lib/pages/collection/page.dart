import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/pages/collection/bloc/gem_year_ids_fetch/bloc.dart';
import 'package:chuckle_chest/pages/gem/bloc/_bloc.dart';
import 'package:chuckle_chest/shared/cubit/_cubit.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CCollectionPage}
///
/// The page for displaying a collection.
///
/// {@endtemplate}
@RoutePage()
class CCollectionPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CCollectionPage}
  const CCollectionPage({
    required this.year,
    super.key,
  });

  /// The ID of the chesdt to display.
  final int year;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CGemYearIDsFetchBloc(
            gemRepository: context.read(),
            chestID: context.read<CCurrentChestCubit>().state.id,
            year: year,
          ),
        ),
        BlocProvider(
          create: (context) => CGemFetchBloc(gemRepository: context.read()),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CGemYearIDsFetchBloc, CGemYearIDsFetchState>(
      builder: (context, state) => Scaffold(
        appBar: CAppBar(context: context, title: Text(year.toString())),
        body: switch (state) {
          CGemYearIDsFetchInProgress() =>
            const Center(child: CCradleLoadingIndicator()),
          CGemYearIDsFetchFailure() =>
            const Center(child: Icon(Icons.error_rounded)),
          CGemYearIDsFetchSuccess(ids: final ids) => PageView.builder(
              itemCount: ids.length,
              itemBuilder: (context, index) => CAnimatedGemView(
                gemID: ids[index],
              ),
            ),
        },
      ),
    );
  }
}
