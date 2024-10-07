import 'package:auto_route/auto_route.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/pages/gem/bloc/_bloc.dart';
import 'package:chuckle_chest/shared/views/collection/bloc/collection_view/bloc.dart';
import 'package:chuckle_chest/shared/views/collection/widgets/animated_gem.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
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
      CEditGemRoute(gem: bloc.state.currentGem),
    );

    if (context.mounted && result != null) {
      context.read<CCollectionViewCubit>().onGemEdited(result as CGem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CCollectionViewCubit(
        gemRepository: context.read(),
        gemIDs: gemIDs,
        onNewGem: (gemID) =>
            context.read<CGemFetchBloc>().add(CGemFetchRequested(gemID: gemID)),
      ),
      child: Builder(
        builder: (context) => BlocListener<CGemFetchBloc, CGemFetchState>(
          listener: (context, state) => context
              .read<CCollectionViewCubit>()
              .onGemFetched((state as CGemFetchSuccess).gem),
          listenWhen: (previous, current) => current is CGemFetchSuccess,
          child: Scaffold(
            appBar: CAppBar(
              context: context,
              title: BlocBuilder<CCollectionViewCubit, CCollectionViewState>(
                builder: (context, state) => Text(state.appBarTitle),
              ),
              actions: [
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
                  BlocBuilder<CGemFetchBloc, CGemFetchState>(
                buildWhen: (previous, current) =>
                    current.gemID == gemIDs[index],
                builder: (context, state) => switch (state) {
                  CGemFetchInitial() =>
                    const Center(child: CCradleLoadingIndicator()),
                  CGemFetchInProgress() =>
                    const Center(child: CCradleLoadingIndicator()),
                  CGemFetchFailure() =>
                    const Center(child: Icon(Icons.error_rounded)),
                  CGemFetchSuccess(gem: final gem) => CAnimatedGem(gem: gem),
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
