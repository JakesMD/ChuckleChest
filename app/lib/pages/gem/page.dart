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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CGemFetchCubit(gemRepository: context.read()),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CGemFetchCubit, CGemFetchState>(
            listener: (context, state) => switch (state.failure) {
              CGemFetchException.notFound =>
                const CErrorSnackBar(message: "We couldn't find that gem.")
                    .show(context),
              CGemFetchException.unknown =>
                const CErrorSnackBar().show(context),
            },
            listenWhen: (_, state) =>
                state.status == CRequestCubitStatus.failed,
          ),
        ],
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    );

    return Theme(
      data: Theme.of(context).copyWith(colorScheme: colorScheme),
      child: Scaffold(body: CCollectionView(gemIDs: [gemID])),
    );
  }
}
