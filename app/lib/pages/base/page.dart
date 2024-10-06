import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/base/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CBasePage}
///
/// The root page that loads the user's data.
///
/// It triggers a session refresh to fetch the user's latest permissions and
/// chests.
///
/// Only after the session refresh has completed will the user be navigated to
/// the [AutoRouter].
///
/// {@endtemplate}
@RoutePage()
class CBasePage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CBasePage}
  const CBasePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CSessionRefreshCubit(authRepository: context.read())
        ..refreshSession(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CSessionRefreshCubit, CSessionRefreshState>(
        builder: (context, state) => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: state.status != CRequestCubitStatus.failed
                    ? CCradleLoadingIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : Text(context.cAppL10n.snackBar_error_defaultMessage),
              ),
            ),
            if (state.status == CRequestCubitStatus.succeeded)
              const Positioned.fill(child: AutoRouter()),
          ],
        ),
      ),
    );
  }
}
