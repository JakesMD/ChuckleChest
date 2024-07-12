import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/pages/home/bloc/session_refresh/bloc.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:cpub/auto_route.dart';
import 'package:cpub/flutter_bloc.dart';
import 'package:flutter/material.dart';

/// {@template CHomePage}
///
/// The root page that loads the users data.
///
/// {@endtemplate}
@RoutePage()
class CHomePage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CHomePage}
  const CHomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CSessionRefreshBloc(
        authRepository: context.read<CAuthRepository>(),
      )..add(CSessionRefreshRequested()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CSessionRefreshBloc, CSessionRefreshState>(
      builder: (context, state) {
        if (state is CSessionRefreshSuccess) {
          return const AutoRouter();
        }
        return Scaffold(
          body: Center(
            child: CCradleLoadingIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      },
    );
  }
}
