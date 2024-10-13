import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CGetStartedPageMoreMenu}
///
/// The button on the app bar of the get started page that opens a menu with
/// additional options, such as signing out.
///
/// {@endtemplate}
class CGetStartedPageMoreMenu extends StatelessWidget {
  /// {@macro CGetStartedPageMoreMenu}
  const CGetStartedPageMoreMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CSignoutCubit, CSignoutState>(
      builder: (context, state) => PopupMenuButton(
        icon: const Icon(Icons.more_vert_rounded),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            onTap: state.status != CRequestCubitStatus.inProgress
                ? () => context.read<CSignoutCubit>().signOut()
                : null,
            child: state.status != CRequestCubitStatus.inProgress
                ? Text(context.cAppL10n.getStartedPage_logoutButton)
                : const Center(
                    child: CCradleLoadingIndicator(ballSize: 8),
                  ),
          ),
        ],
      ),
    );
  }
}
