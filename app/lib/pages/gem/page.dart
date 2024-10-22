import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CGemPage}
///
/// The page that displays a funny conversation.
///
/// It is navigated to after a gem has been created.
///
/// {@endtemplate}
@RoutePage()
class CGemPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CGemPage}
  const CGemPage({@PathParam() required this.gemID, super.key});

  /// The unique identifier of the gem to display.
  final String gemID;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CGemFetchCubit(gemRepository: context.read()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    );

    return Theme(
      data: Theme.of(context).copyWith(colorScheme: colorScheme),
      child: Scaffold(
        body: CCollectionView<CGemFetchCubit, CGemFetchState,
            CGemFetchException, CGem>(
          gemTokens: [gemID],
          userRole: context.read<CCurrentChestCubit>().state.userRole,
          gemFromState: (state) => state.gem,
          gemTokenFromState: (state) => state.gemID,
          triggerFetchGem: (context, token) =>
              context.read<CGemFetchCubit>().fetchGem(gemID: token),
          onFetchFailed: (failure) => switch (failure) {
            CGemFetchException.notFound =>
              const CErrorSnackBar(message: "We couldn't find that gem.")
                  .show(context),
            CGemFetchException.unknown => const CErrorSnackBar().show(context),
          },
        ),
      ),
    );
  }
}
