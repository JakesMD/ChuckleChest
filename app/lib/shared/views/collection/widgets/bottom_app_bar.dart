import 'package:chuckle_chest/shared/_shared.dart';
import 'package:chuckle_chest/shared/views/collection/logic/_logic.dart';
import 'package:chuckle_chest/shared/views/collection/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signed_spacing_flex/signed_spacing_flex.dart';

/// {@template CCollectionViewBottomAppBar}
///
/// The bottom app bar for the [CCollectionView].
///
/// It displays a share button that opens a modal bottom sheet with options to
/// copy or delete the link to the current gem.
///
/// {@endtemplate}
class CCollectionViewBottomAppBar extends StatelessWidget {
  /// {@macro CCollectionViewBottomAppBar}
  const CCollectionViewBottomAppBar({required this.onShared, super.key});

  /// Called when the share button is pressed.
  final void Function(String token) onShared;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SignedSpacingRow(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<CCollectionViewCubit, CCollectionViewState>(
            builder: (context, viewState) =>
                BlocBuilder<CGemShareCubit, CGemShareState>(
              builder: (context, shareState) => BlocBuilder<
                  CGemShareTokenCreationCubit, CGemShareTokenCreationState>(
                builder: (context, tokenState) => IconButton(
                  onPressed: viewState.currentGem != null &&
                          shareState.status != CRequestCubitStatus.inProgress &&
                          tokenState.status != CRequestCubitStatus.inProgress
                      ? () => CShareSheet(
                            gem: viewState.currentGem!,
                            onShared: onShared,
                            shareTokenCreationCubit: context.read(),
                          ).show(context)
                      : null,
                  icon: shareState.status != CRequestCubitStatus.inProgress &&
                          tokenState.status != CRequestCubitStatus.inProgress
                      ? const Icon(Icons.share_rounded)
                      : const CBouncyBallLoadingIndicator(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
