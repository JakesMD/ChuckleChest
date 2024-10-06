import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/pages/gem/bloc/_bloc.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CGemPage}
///
/// The page that displays a funny conversation.
///
/// {@endtemplate}
@RoutePage()
class CGemPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CGemPage}
  const CGemPage({
    @PathParam() required this.gemID,
    super.key,
  });

  /// The unique identifier of the gem.
  final String gemID;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CGemFetchBloc(gemRepository: context.read()),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<CGemFetchBloc, CGemFetchState>(
          listener: (context, state) {
            return switch ((state as CGemFetchFailure).exception) {
              CGemFetchException.notFound => const CErrorSnackBar(
                  message: "We couldn't find that gem.",
                ).show(context),
              CGemFetchException.unknown =>
                const CErrorSnackBar().show(context),
            };
          },
          listenWhen: (_, state) => state is CGemFetchFailure,
        ),
      ],
      child: Theme(
        data: Theme.of(context).copyWith(colorScheme: colorScheme),
        child: Scaffold(
          body: CCollectionView(gemIDs: [gemID]),
          // bottomNavigationBar: CGemPageBottomAppBar(gemID: gemID),
        ),
      ),
    );
  }
}
