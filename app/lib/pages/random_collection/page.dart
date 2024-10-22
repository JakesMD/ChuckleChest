import 'package:auto_route/auto_route.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/pages/random_collection/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CRandomCollectionPage}
///
/// The page for displaying a collection of random gems.
///
/// It fetches the IDs of random gems and then displays them in a
/// [CCollectionView] which allow the user to view the gems one by one.
///
/// {@endtemplate}
@RoutePage()
class CRandomCollectionPage extends StatelessWidget
    implements AutoRouteWrapper {
  /// {@macro CRandomCollectionPage}
  const CRandomCollectionPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CRandomGemIDsFetchCubit(
            gemRepository: context.read(),
            chestID: context.read<CCurrentChestCubit>().state.id,
          )..fetchRandomGemIDs(),
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
    return BlocBuilder<CRandomGemIDsFetchCubit, CRandomGemIDsFetchState>(
      builder: (context, state) => Scaffold(
        body: switch (state.status) {
          CRequestCubitStatus.initial =>
            const Center(child: CCradleLoadingIndicator()),
          CRequestCubitStatus.inProgress =>
            const Center(child: CCradleLoadingIndicator()),
          CRequestCubitStatus.failed =>
            const Center(child: Icon(Icons.error_rounded)),
          CRequestCubitStatus.succeeded => CCollectionView<CGemFetchCubit,
                CGemFetchState, CGemFetchException, CGem>(
              gemTokens: state.ids,
              userRole: context.read<CCurrentChestCubit>().state.userRole,
              gemFromState: (state) => state.gem,
              gemTokenFromState: (state) => state.gemID,
              triggerFetchGem: (context, token) =>
                  context.read<CGemFetchCubit>().fetchGem(gemID: token),
              onFetchFailed: (failure) => switch (failure) {
                CGemFetchException.notFound =>
                  const CErrorSnackBar(message: "We couldn't find that gem.")
                      .show(context),
                CGemFetchException.unknown =>
                  const CErrorSnackBar().show(context),
              },
            ),
        },
      ),
    );
  }
}
