import 'package:ccore/ccore.dart';
import 'package:cgem_repository/cgem_repository.dart';
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
    O> extends CWrappedWidget {
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

  @override
  Widget wrapper(BuildContext context) {
    if (gemTokens.isEmpty) return builder(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CCollectionViewCubit(
            gemTokens: gemTokens,
            onNewGem: (token) => triggerFetchGem(context, token),
          ),
        ),
        BlocProvider(
          create: (context) => CGemShareCubit(gemRepository: context.read()),
        ),
        if (userRole != CUserRole.viewer)
          BlocProvider(
            create: (context) => CGemShareTokenCreationCubit(
              gemRepository: context.read(),
              chestID: context.read<CCurrentChestCubit>().state.id,
            ),
          ),
      ],
      child: Builder(
        builder: (context) => MultiBlocListener(
          listeners: [
            BlocListener<C, S>(
              listener: (context, state) => switch (state.status) {
                CRequestCubitStatus.initial => null,
                CRequestCubitStatus.inProgress => null,
                CRequestCubitStatus.failed => onFetchFailed(state.failure),
                CRequestCubitStatus.succeeded =>
                  context.read<CCollectionViewCubit>().onGemFetched(
                        gemFromState(state),
                        gemTokenFromState(state),
                      ),
              },
            ),
            BlocListener<CGemShareCubit, CGemShareState>(
              listener: (context, state) => switch (state.status) {
                CRequestCubitStatus.initial => null,
                CRequestCubitStatus.inProgress => null,
                CRequestCubitStatus.failed =>
                  const CErrorSnackBar().show(context),
                CRequestCubitStatus.succeeded => state.shareMethod ==
                        CGemShareMethod.clipboard
                    ? CInfoSnackBar(message: context.cAppL10n.copiedToClipboard)
                        .show(context)
                    : null,
              },
            ),
            if (userRole != CUserRole.viewer)
              BlocListener<CGemShareTokenCreationCubit,
                  CGemShareTokenCreationState>(
                listener: (context, state) => switch (state.status) {
                  CRequestCubitStatus.initial => null,
                  CRequestCubitStatus.inProgress => null,
                  CRequestCubitStatus.failed =>
                    const CErrorSnackBar().show(context),
                  CRequestCubitStatus.succeeded => _updateGemShareToken(
                      context,
                      state.gemID,
                      state.shareToken,
                    ),
                },
              ),
          ],
          child: builder(context),
        ),
      ),
    );
  }

  void _updateGemShareToken(
    BuildContext context,
    String gemID,
    String shareToken,
  ) {
    context.read<CCollectionViewCubit>().onShareTokenCreated(gemID, shareToken);
    _shareGem(context, shareToken);
  }

  void _shareGem(BuildContext context, String shareToken) {
    final box = context.findRenderObject() as RenderBox?;
    final sharePositionOrigin = box!.localToGlobal(Offset.zero) & box.size;

    context.read<CGemShareCubit>().shareGem(
          shareToken: shareToken,
          message: context.cAppL10n.gem_share_message,
          subject: context.cAppL10n.gem_share_subject,
          sharePositionOrigin: sharePositionOrigin,
        );
  }

  @override
  Widget builder(BuildContext context) {
    if (gemTokens.isEmpty) {
      return Scaffold(
        appBar: CAppBar(
          context: context,
          title: Text(context.cAppL10n.collectionView_noGemsTitle),
        ),
      );
    }
    return Scaffold(
      appBar: CCollectionViewAppBar(userRole: userRole),
      body: PageView.builder(
        onPageChanged: (index) => _onPageChanged(context, index),
        itemCount: gemTokens.length,
        itemBuilder: (context, index) => BlocBuilder<C, S>(
          buildWhen: (_, state) => gemTokenFromState(state) == gemTokens[index],
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
      bottomNavigationBar: userRole != CUserRole.viewer
          ? CCollectionViewBottomAppBar(
              onShared: (token) => _shareGem(context, token),
            )
          : null,
    );
  }
}
