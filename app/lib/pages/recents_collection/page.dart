import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/pages/recents_collection/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CRecentsCollectionPage}
///
/// The page for displaying a collection of the most recent gems.
///
/// It fetches the IDs of the recent gems and then displays them in a
/// [CCollectionView] which allow the user to view the gems one by one.
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
          create: (context) => CRecentGemIDsFetchCubit(
            gemRepository: context.read(),
            chestID: context.read<CCurrentChestCubit>().state.id,
          )..fetchRecentGemIDs(),
        ),
        BlocProvider(
          create: (context) => CGemFetchCubit(gemRepository: context.read()),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CRecentGemIDsFetchCubit, CRecentGemIDsFetchState>(
      builder: (context, state) => Scaffold(
        body: switch (state.status) {
          CRequestCubitStatus.initial =>
            const Center(child: CCradleLoadingIndicator()),
          CRequestCubitStatus.inProgress =>
            const Center(child: CCradleLoadingIndicator()),
          CRequestCubitStatus.failed =>
            const Center(child: Icon(Icons.error_rounded)),
          CRequestCubitStatus.succeeded => CCollectionView(gemIDs: state.ids),
        },
      ),
    );
  }
}
