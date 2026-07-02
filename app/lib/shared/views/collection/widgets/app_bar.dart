import 'package:auto_route/auto_route.dart';
import 'package:ccore/ccore.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:chuckle_chest/shared/views/collection/dialogs/_dialogs.dart';
import 'package:chuckle_chest/shared/views/collection/logic/_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The actions available in the [CCollectionViewAppBar]'s gem menu.
enum _CGemMenuAction {
  /// Edit the gem.
  edit,

  /// Delete the gem.
  delete,
}

/// {@template CCollectionViewAppBar}
///
/// The app bar for the [CCollectionView].
///
/// It displays the title of the current gem and a menu with edit and delete
/// options if the user has the permission to edit the gem.
///
/// {@endtemplate}
class CCollectionViewAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  /// {@macro CCollectionViewAppBar}
  const CCollectionViewAppBar({required this.userRole, super.key});

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

  void _onDeletePressed(BuildContext context) {
    final gem = context.read<CCollectionViewCubit>().state.currentGem;
    if (gem == null) return;

    CDeleteGemDialog(
      gemID: gem.id,
      cubit: context.read<CGemDeleteCubit>(),
    ).show(context);
  }

  void _onMenuSelected(BuildContext context, _CGemMenuAction action) {
    switch (action) {
      case _CGemMenuAction.edit:
        _onEditPressed(context);
      case _CGemMenuAction.delete:
        _onDeletePressed(context);
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
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
                ? PopupMenuButton<_CGemMenuAction>(
                    key: const Key('collection_view_gem_menu_button'),
                    icon: const Icon(Icons.more_vert_rounded),
                    onSelected: (action) => _onMenuSelected(context, action),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        key: const Key('collection_view_gem_menu_edit_item'),
                        value: _CGemMenuAction.edit,
                        child: ListTile(
                          leading: const Icon(Icons.edit_rounded),
                          title: Text(context.cAppL10n.edit),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      PopupMenuItem(
                        key: const Key('collection_view_gem_menu_delete_item'),
                        value: _CGemMenuAction.delete,
                        child: ListTile(
                          leading: const Icon(Icons.delete_rounded),
                          title: Text(context.cAppL10n.delete),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
      ],
    );
  }
}
