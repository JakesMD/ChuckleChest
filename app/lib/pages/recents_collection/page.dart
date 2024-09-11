import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/pages/gem/bloc/_bloc.dart';
import 'package:chuckle_chest/pages/recents_collection/bloc/recent_gem_ids_fetch/bloc.dart';
import 'package:chuckle_chest/shared/cubit/_cubit.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CRecentsCollectionPage}
///
/// The page for displaying a collection of the most recent gems.
///
/// {@endtemplate}
@RoutePage()
class CRecentsCollectionPage extends StatelessWidget
    implements AutoRouteWrapper {
  /// {@macro CRecentsCollectionPage}
  const CRecentsCollectionPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CRecentGemIDsFetchBloc(
            gemRepository: context.read(),
            chestID: context.read<CCurrentChestCubit>().state.id,
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
    return BlocBuilder<CRecentGemIDsFetchBloc, CRecentGemIDsFetchState>(
      builder: (context, state) => Scaffold(
        body: switch (state) {
          CRecentGemIDsFetchInProgress() =>
            const Center(child: CCradleLoadingIndicator()),
          CRecentGemIDsFetchFailure() =>
            const Center(child: Icon(Icons.error_rounded)),
          CRecentGemIDsFetchSuccess(ids: final ids) =>
            CCollectionView(gemIDs: ids),
        },
      ),
    );
  }
}
