import 'package:auto_route/auto_route.dart';
import 'package:ccore/ccore.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:chuckle_chest/shared/views/collection/logic/_logic.dart';
import 'package:chuckle_chest/shared/views/collection/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallard_bloc/mallard_bloc.dart';

/// {@template CCollectionView}
///
/// The view that fetches and displays the gems with the given [gemTokens].
///
/// It MUST be disconnected from all authentication and authorization logic
/// because it can be used by non authenticated users viewing shared gems.
///
/// {@endtemplate}
class CCollectionView<
  C extends Cubit<S>,
  S extends CRequestCubitState<F, O>,
  F,
  O
>
    extends StatefulWidget {
  /// {@macro CCollectionView}
  const CCollectionView({
    required this.gemTokens,
    required this.userRole,
    required this.gemFromState,
    required this.gemTokenFromState,
    required this.onFetchFailed,
    required this.triggerFetchGem,
    this.isShared = false,
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

  /// Whether this view is being shown on the public shared-gem page.
  ///
  /// When `true`, no bottom app bar is displayed, since sharing and liking
  /// gems both require the user to be viewing gems within a chest.
  final bool isShared;

  /// The function to extract the gem from the state.
  final CGem Function(S state) gemFromState;

  /// The function to extract the gem token from the state.
  final String Function(S state) gemTokenFromState;

  /// The function to call when the fetch fails.
  final void Function(F failure) onFetchFailed;

  /// The function to call to fetch the gem with the given token.
  final void Function(BuildContext context, String token) triggerFetchGem;

  @override
  State<CCollectionView<C, S, F, O>> createState() =>
      _CCollectionViewState<C, S, F, O>();
}

class _CCollectionViewState<
  C extends Cubit<S>,
  S extends CRequestCubitState<F, O>,
  F,
  O
>
    extends State<CCollectionView<C, S, F, O>> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(BuildContext context, int index) =>
      context.read<CCollectionViewCubit>().onPageChanged(index);

  void _onGemDeleted(BuildContext context, String gemID) {
    final cubit = context.read<CCollectionViewCubit>()..removeGem(gemID);
    if (cubit.state.gems.isEmpty) {
      context.router.maybePop();
    } else {
      _pageController.jumpToPage(cubit.state.currentIndex);
    }
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

  Widget _buildBody(BuildContext context) {
    if (widget.gemTokens.isEmpty) {
      return Scaffold(
        appBar: CAppBar(
          context: context,
          title: Text(context.cAppL10n.collectionView_noGemsTitle),
        ),
      );
    }
    return Scaffold(
      appBar: CCollectionViewAppBar(userRole: widget.userRole),
      body: BlocBuilder<CCollectionViewCubit, CCollectionViewState>(
        buildWhen: (prev, curr) => prev.gems.length != curr.gems.length,
        builder: (context, collectionState) => PageView.builder(
          controller: _pageController,
          onPageChanged: (index) => _onPageChanged(context, index),
          itemCount: collectionState.gems.length,
          itemBuilder: (context, index) => BlocBuilder<C, S>(
            buildWhen: (_, state) =>
                widget.gemTokenFromState(state) ==
                collectionState.gems[index].$1,
            builder: (context, fetchState) => switch (fetchState.status) {
              CRequestCubitStatus.initial => const Center(
                child: CCradleLoadingIndicator(),
              ),
              CRequestCubitStatus.inProgress => const Center(
                child: CCradleLoadingIndicator(),
              ),
              CRequestCubitStatus.failed => const Center(
                child: Icon(Icons.error_rounded),
              ),
              CRequestCubitStatus.succeeded =>
                BlocBuilder<CCollectionViewCubit, CCollectionViewState>(
                  buildWhen: (_, state) =>
                      state.currentGem?.id ==
                          widget.gemFromState(fetchState).id ||
                      state.needsRestart,
                  builder: (context, state) => state.currentGem != null
                      ? CAnimatedGem(
                          key: UniqueKey(),
                          gem: state.currentGem!,
                          isLastGem: state.isLastGem,
                        )
                      : const SizedBox(),
                ),
            },
          ),
        ),
      ),
      bottomNavigationBar: widget.isShared
          ? null
          : CCollectionViewBottomAppBar(
              showShareButton: widget.userRole != CUserRole.viewer,
              onShared: (token) => _shareGem(context, token),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.gemTokens.isEmpty) return _buildBody(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CCollectionViewCubit(
            gemTokens: widget.gemTokens,
            onNewGem: (token) => widget.triggerFetchGem(context, token),
          ),
        ),
        BlocProvider(
          create: (context) => CGemShareCubit(gemRepository: context.read()),
        ),
        if (widget.userRole != CUserRole.viewer) ...[
          BlocProvider(
            create: (context) => CGemShareTokenCreationCubit(
              gemRepository: context.read(),
              chestID: context.read<CCurrentChestCubit>().state.id,
            ),
          ),
          BlocProvider(
            create: (context) => CGemDeleteCubit(gemRepository: context.read()),
          ),
        ],
      ],
      child: Builder(
        builder: (context) => MultiBlocListener(
          listeners: [
            BlocListener<C, S>(
              listener: (context, state) => switch (state.status) {
                CRequestCubitStatus.initial => null,
                CRequestCubitStatus.inProgress => null,
                CRequestCubitStatus.failed => widget.onFetchFailed(
                  state.failure,
                ),
                CRequestCubitStatus.succeeded =>
                  context.read<CCollectionViewCubit>().onGemFetched(
                    widget.gemFromState(state),
                    widget.gemTokenFromState(state),
                  ),
              },
            ),
            BlocListener<CGemShareCubit, CGemShareState>(
              listener: (context, state) => switch (state.status) {
                CRequestCubitStatus.initial => null,
                CRequestCubitStatus.inProgress => null,
                CRequestCubitStatus.failed => const CErrorSnackBar().show(
                  context,
                ),
                CRequestCubitStatus.succeeded =>
                  state.shareMethod == CGemShareMethod.clipboard
                      ? CInfoSnackBar(
                          message: context.cAppL10n.copiedToClipboard,
                        ).show(context)
                      : null,
              },
            ),
            if (widget.userRole != CUserRole.viewer) ...[
              BlocListener<
                CGemShareTokenCreationCubit,
                CGemShareTokenCreationState
              >(
                listener: (context, state) => switch (state.status) {
                  CRequestCubitStatus.initial => null,
                  CRequestCubitStatus.inProgress => null,
                  CRequestCubitStatus.failed => const CErrorSnackBar().show(
                    context,
                  ),
                  CRequestCubitStatus.succeeded => _updateGemShareToken(
                    context,
                    state.gemID,
                    state.shareToken,
                  ),
                },
              ),
              BlocListener<CGemDeleteCubit, CGemDeleteState>(
                listener: (context, state) => switch (state.status) {
                  TaskBlocStatus.initial => null,
                  TaskBlocStatus.inProgress => null,
                  TaskBlocStatus.failed => const CErrorSnackBar().show(
                    context,
                  ),
                  TaskBlocStatus.succeeded => _onGemDeleted(
                    context,
                    state.success!,
                  ),
                },
              ),
            ],
          ],
          child: _buildBody(context),
        ),
      ),
    );
  }
}
