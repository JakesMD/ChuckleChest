import 'package:auto_route/auto_route.dart';
import 'package:ccore/ccore.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:chuckle_chest/shared/views/collection/logic/_logic.dart';
import 'package:chuckle_chest/shared/views/collection/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CCollectionView}
///
/// The view that fetches and displays the gems with the given [gemIDs].
///
/// {@endtemplate}
class CCollectionView extends StatelessWidget {
  /// {@macro CCollectionView}
  const CCollectionView({required this.gemIDs, super.key});

  /// The IDs of the gems to display.
  final List<String> gemIDs;

  void _onPageChanged(BuildContext context, int index) =>
      context.read<CCollectionViewCubit>().onPageChanged(index);

  Future<void> _onEditPressed(BuildContext context) async {
    final bloc = context.read<CCollectionViewCubit>();

    final result = await context.router.push(
      CEditGemRoute(initialGem: bloc.state.currentGem),
    );

    if (context.mounted && result != null) {
      context.read<CCollectionViewCubit>().onGemEdited(result as CGem);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isViewer =
        context.read<CCurrentChestCubit>().state.userRole == CUserRole.viewer;

    if (gemIDs.isEmpty) {
      return Scaffold(
        appBar: CAppBar(
          context: context,
          title: Text(context.cAppL10n.collectionView_nowGemsTitle),
        ),
      );
    }
    return BlocProvider(
      create: (context) => CCollectionViewCubit(
        gemIDs: gemIDs,
        onNewGem: (gemID) =>
            context.read<CGemFetchCubit>().fetchGem(gemID: gemID),
      ),
      child: Builder(
        builder: (context) => BlocListener<CGemFetchCubit, CGemFetchState>(
          listener: (context, state) => switch (state.status) {
            CRequestCubitStatus.initial => null,
            CRequestCubitStatus.inProgress => null,
            CRequestCubitStatus.failed => switch (state.failure) {
                CGemFetchException.notFound =>
                  const CErrorSnackBar(message: "We couldn't find that gem.")
                      .show(context),
                CGemFetchException.unknown =>
                  const CErrorSnackBar().show(context),
              },
            CRequestCubitStatus.succeeded =>
              context.read<CCollectionViewCubit>().onGemFetched(state.gem),
          },
          child: Scaffold(
            appBar: CAppBar(
              context: context,
              title: BlocBuilder<CCollectionViewCubit, CCollectionViewState>(
                builder: (context, state) => Text(state.appBarTitle),
              ),
              actions: [
                if (!isViewer)
                  BlocBuilder<CCollectionViewCubit, CCollectionViewState>(
                    builder: (context, state) => state.canEdit
                        ? IconButton(
                            icon: const Icon(Icons.edit_rounded),
                            onPressed: () => _onEditPressed(context),
                          )
                        : const SizedBox(),
                  ),
              ],
            ),
            body: PageView.builder(
              onPageChanged: (index) => _onPageChanged(context, index),
              itemCount: gemIDs.length,
              itemBuilder: (context, index) =>
                  BlocBuilder<CGemFetchCubit, CGemFetchState>(
                buildWhen: (_, state) => state.gemID == gemIDs[index],
                builder: (context, fetchState) => switch (fetchState.status) {
                  CRequestCubitStatus.initial =>
                    const Center(child: CCradleLoadingIndicator()),
                  CRequestCubitStatus.inProgress =>
                    const Center(child: CCradleLoadingIndicator()),
                  CRequestCubitStatus.failed =>
                    const Center(child: Icon(Icons.error_rounded)),
                  CRequestCubitStatus.succeeded =>
                    BlocBuilder<CCollectionViewCubit, CCollectionViewState>(
                      buildWhen: (_, state) =>
                          state.currentGem?.id == fetchState.gemID,
                      builder: (context, state) => state.currentGem != null
                          ? CAnimatedGem(gem: state.currentGem!)
                          : const SizedBox(),
                    ),
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
