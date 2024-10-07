import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/shared/cubit/_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CHomePageAppBarTitle}
///
/// The title for the app bar on the home page.
///
/// This widget displays the current chest name and allows the user to switch
/// between chests.
///
/// {@endtemplate}
class CHomePageAppBarTitle extends StatelessWidget {
  /// {@macro CHomePageAppBarTitle}
  const CHomePageAppBarTitle({
    required this.onChestSelected,
    super.key,
  });

  /// Callback for when a chest is selected.
  final void Function(BuildContext, CAuthUserChest) onChestSelected;

  @override
  Widget build(BuildContext context) {
    final chests = context.read<CAuthRepository>().currentUser!.chests;
    final currentChest = context.read<CCurrentChestCubit>().state;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(currentChest.name),
        if (chests.length > 1)
          PopupMenuButton(
            icon: const Icon(Icons.swap_vert_rounded),
            itemBuilder: (context) {
              return chests
                  .map(
                    (chest) => PopupMenuItem(
                      onTap: () => onChestSelected(context, chest),
                      child: Text(chest.name),
                    ),
                  )
                  .toList();
            },
          ),
      ],
    );
  }
}
