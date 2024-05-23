import 'dart:math';

import 'package:ccore/ccore.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/pages/gem/bloc/_bloc.dart';
import 'package:chuckle_chest/pages/gem/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/bloc/_bloc.dart';
import 'package:chuckle_chest/shared/physics/_physics.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:cpub/auto_route.dart';
import 'package:cpub/flutter_bloc.dart';
import 'package:flutter/material.dart';

/// {@template CGemPage}
///
/// The page that displays a funny conversation.
///
/// {@endtemplate}
@RoutePage()
class CGemPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CGemPage}
  CGemPage({
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
          create: (context) => CGemShareBloc(
            gemRepository: context.read<CGemRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => CGemFetchBloc(
            gemRepository: context.read<CGemRepository>(),
            gemID: gemID,
          ),
        ),
      ],
      child: this,
    );
  }

  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<CGemShareBloc, CGemShareState>(
          listener: (context, state) => switch (state) {
            CGemShareInitial() => null,
            CGemShareInProgress() => null,
            CGemShareFailure() => const CErrorSnackBar().show(context),
            CGemShareSuccess(method: final method) => switch (method) {
                CGemShareMethod.dialog => null,
                CGemShareMethod.clipboard =>
                  const CInfoSnackBar(message: 'Copied!').show(context),
              },
          },
        ),
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
          appBar: const CGemPageAppBar(),
          body: BlocBuilder<CGemFetchBloc, CGemFetchState>(
            buildWhen: (_, state) => state is CGemFetchSuccess,
            builder: (context, state) {
              if (state is CGemFetchSuccess) {
                return ListView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(24),
                  physics: const CAutoScrollingPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  children: [
                    CAnimatedTypingText(
                      delay: Duration.zero,
                      text: state.gem.occurredAt.cLocalize(
                        context,
                        dateFormat: CDateFormat.yearMonth,
                      ),
                      textStyle: Theme.of(context).textTheme.labelMedium!,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    CAnimatedGem(gem: state.gem, isAnimated: true),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
          floatingActionButton: CScrollToBottomFAB(
            scrollController: _scrollController,
          ),
          bottomNavigationBar: CGemPageBottomAppBar(gemID: gemID),
        ),
      ),
    );
  }
}
