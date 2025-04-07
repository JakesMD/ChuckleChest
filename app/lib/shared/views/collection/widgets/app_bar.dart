import 'package:auto_route/auto_route.dart';
import 'package:ccore/ccore.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:chuckle_chest/shared/views/collection/logic/_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CCollectionViewAppBar}
///
/// The app bar for the [CCollectionView].
///
/// It displays the title of the current gem and an edit button if the user
/// has the permission to edit the gem.
///
/// {@endtemplate}
class CCollectionViewAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  /// {@macro CCollectionViewAppBar}
  const CCollectionViewAppBar({
    required this.userRole,
    super.key,
  });

  /// The role of the user viewing the gems.
  ///
  /// If the user is not authenticated, this should be [CUserRole.viewer].
  final CUserRole userRole;

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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BlocBuilder<CCollectionViewCubit, CCollectionViewState>(
        builder: (context, state) => Text(
          state.currentGem != null
              ? context.cAppL10n.gem_title(state.currentGem!.number)
              : '',
        ),
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
    );
  }
}
