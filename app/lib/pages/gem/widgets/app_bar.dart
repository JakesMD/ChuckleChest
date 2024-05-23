import 'package:chuckle_chest/pages/gem/bloc/_bloc.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:cpub/flutter_bloc.dart';
import 'package:flutter/material.dart';

/// {@template CGemPageAppBar}
///
/// The app bar for the gem page.
///
/// {@endtemplate}
class CGemPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// {@macro CGemPageAppBar}
  const CGemPageAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: BlocBuilder<CGemFetchBloc, CGemFetchState>(
        builder: (context, state) => switch (state) {
          CGemFetchInProgress() => const CCradleLoadingIndicator(),
          CGemFetchSuccess(gem: final gem) => Text(gem.number.toString()),
          CGemFetchFailure() => const Icon(Icons.error_rounded),
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      centerTitle: true,
    );
  }
}
