import 'package:auto_route/auto_route.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/pages/favourites_collection/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallard_bloc/mallard_bloc.dart';

/// {@template CFavouritesCollectionPage}
///
/// The page for displaying a collection of the gems the user has liked.
///
/// It fetches the IDs of the liked gems and then displays them in a
/// [CCollectionView] which allow the user to view the gems one by one.
///
/// {@endtemplate}
@RoutePage()
class CFavouritesCollectionPage extends StatelessWidget
    implements AutoRouteWrapper {
  /// {@macro CFavouritesCollectionPage}
  const CFavouritesCollectionPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CFavouriteGemIDsFetchCubit(
            gemRepository: context.read(),
            chestID: context.read<CCurrentChestCubit>().state.id,
          )..fetchLikedGemIDs(),
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
    return BlocBuilder<CFavouriteGemIDsFetchCubit, CFavouriteGemIDsFetchState>(
      builder: (context, state) => Scaffold(
        body: switch (state.status) {
          TaskBlocStatus.initial => const Center(
            child: CCradleLoadingIndicator(),
          ),
          TaskBlocStatus.inProgress => const Center(
            child: CCradleLoadingIndicator(),
          ),
          TaskBlocStatus.failed => const Center(
            child: Icon(Icons.error_rounded),
          ),
          TaskBlocStatus.succeeded =>
            CCollectionView<
              CGemFetchCubit,
              CGemFetchState,
              CGemFetchException,
              CGem
            >(
              gemTokens: state.success!,
              userRole: context.read<CCurrentChestCubit>().state.userRole,
              gemFromState: (state) => state.gem,
              gemTokenFromState: (state) => state.gemID,
              triggerFetchGem: (context, token) =>
                  context.read<CGemFetchCubit>().fetchGem(gemID: token),
              onFetchFailed: (failure) => switch (failure) {
                CGemFetchException.notFound => const CErrorSnackBar(
                  message: "We couldn't find that gem.",
                ).show(context),
                CGemFetchException.unknown => const CErrorSnackBar().show(
                  context,
                ),
              },
            ),
        },
      ),
    );
  }
}
