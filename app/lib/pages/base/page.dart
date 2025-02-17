import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/pages/base/logic/_logic.dart';
import 'package:chuckle_chest/pages/base/view/_views.dart';
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
    return BlocBuilder<CSessionRefreshCubit, CSessionRefreshState>(
      builder: (context, state) => switch (state.status) {
        CRequestCubitStatus.initial => const CSessionRefreshingView(),
        CRequestCubitStatus.inProgress => const CSessionRefreshingView(),
        CRequestCubitStatus.failed => const CSessionRefreshFailedView(),
        CRequestCubitStatus.succeeded => const AutoRouter(),
      },
    );
  }
}
