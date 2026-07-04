import 'package:chuckle_chest/shared/_shared.dart';
import 'package:chuckle_chest/shared/views/collection/logic/_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CGemLikeButton}
///
/// The button that toggles whether the current gem in a [CCollectionView] is
/// liked.
///
/// {@endtemplate}
class CGemLikeButton extends StatelessWidget {
  /// {@macro CGemLikeButton}
  const CGemLikeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CCollectionViewCubit, CCollectionViewState>(
      builder: (context, viewState) {
        final gemID = viewState.currentGem?.id;

        return BlocBuilder<CGemLikesCubit, CGemLikesState>(
          builder: (context, likeState) {
            final isLiked =
                gemID != null && likeState.likedGemIDs.contains(gemID);
            final isPending =
                gemID != null && likeState.pendingGemIDs.contains(gemID);

            return IconButton(
              key: const Key('collection_view_like_button'),
              onPressed: gemID == null || isPending
                  ? null
                  : () => context.read<CGemLikesCubit>().toggle(gemID),
              icon: isPending
                  ? const CBouncyBallLoadingIndicator()
                  : Icon(
                      isLiked
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                    ),
            );
          },
        );
      },
    );
  }
}
