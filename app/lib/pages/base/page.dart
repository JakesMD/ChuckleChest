import 'package:auto_route/auto_route.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/base/bloc/session_refresh/bloc.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CBasePage}
///
/// The root page that loads the users data.
///
/// {@endtemplate}
@RoutePage()
class CBasePage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CBasePage}
  const CBasePage({super.key});

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
    return Scaffold(
      body: BlocBuilder<CSessionRefreshBloc, CSessionRefreshState>(
        builder: (context, state) => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: state is! CSessionRefreshFailure
                    ? CCradleLoadingIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : Text(context.cAppL10n.snackBar_error_defaultMessage),
              ),
            ),
            if (state is CSessionRefreshSuccess)
              const Positioned.fill(child: AutoRouter()),
          ],
        ),
      ),
    );
  }
}
