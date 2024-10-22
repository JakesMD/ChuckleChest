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
/// The view that fetches and displays the gems with the given [gemTokens].
///
/// It MUST be disconnected from all authentication and authorization logic
/// because it can be used by non authenticated users viewing shared gems.
///
/// {@endtemplate}
class CCollectionView<C extends Cubit<S>, S extends CRequestCubitState<F, O>, F,
    O> extends StatelessWidget {
  /// {@macro CCollectionView}
  const CCollectionView({
    required this.gemTokens,
    required this.userRole,
    required this.gemFromState,
    required this.gemTokenFromState,
    required this.onFetchFailed,
    required this.triggerFetchGem,
    super.key,
  });

  /// The IDs of the gems to display.
  ///
  /// This can also be the token of a shared gem.
  final List<String> gemTokens;

  /// The role of the user viewing the gems.
  ///
  /// If the user is not authenticated, this should be [CUserRole.viewer].
  final CUserRole userRole;

  /// The function to extract the gem from the state.
  final CGem Function(S state) gemFromState;

  /// The function to extract the gem token from the state.
  final String Function(S state) gemTokenFromState;

  /// The function to call when the fetch fails.
  final void Function(F failure) onFetchFailed;

  /// The function to call to fetch the gem with the given token.
  final void Function(BuildContext context, String token) triggerFetchGem;

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
    if (gemTokens.isEmpty) {
      return Scaffold(
        appBar: CAppBar(
          context: context,
          title: Text(context.cAppL10n.collectionView_nowGemsTitle),
        ),
      );
    }
    return BlocProvider(
      create: (context) => CCollectionViewCubit(
        gemTokens: gemTokens,
        onNewGem: (token) => triggerFetchGem(context, token),
      ),
      child: Builder(
        builder: (context) => BlocListener<C, S>(
          listener: (context, state) => switch (state.status) {
            CRequestCubitStatus.initial => null,
            CRequestCubitStatus.inProgress => null,
            CRequestCubitStatus.failed => onFetchFailed(state.failure),
            CRequestCubitStatus.succeeded => context
                .read<CCollectionViewCubit>()
                .onGemFetched(gemFromState(state), gemTokenFromState(state)),
          },
          child: Scaffold(
            appBar: CAppBar(
              context: context,
              title: BlocBuilder<CCollectionViewCubit, CCollectionViewState>(
                builder: (context, state) => Text(state.appBarTitle),
              ),
              actions: [
                if (userRole != CUserRole.viewer)
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
              itemCount: gemTokens.length,
              itemBuilder: (context, index) => BlocBuilder<C, S>(
                buildWhen: (_, state) =>
                    gemTokenFromState(state) == gemTokens[index],
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
                          state.currentGem?.id == gemFromState(fetchState).id,
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
