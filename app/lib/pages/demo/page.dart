import 'package:auto_route/auto_route.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:ccore/ccore.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/pages/demo/logic/demo_cubit.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CDemoPage}
///
/// The page for the demo on the landing page.
///
/// {@endtemplate}
@RoutePage()
class CDemoPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CDemoPage}
  const CDemoPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CDemoCubit(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CDemoCubit>();

    return Scaffold(
      body: CCollectionView<CDemoCubit, CDemoState, BobsNothing, CSharedGem>(
        gemTokens: cubit.gemTokens,
        userRole: CUserRole.viewer,
        gemFromState: (state) => state.gem,
        gemTokenFromState: (state) => state.gemID,
        triggerFetchGem: (context, token) => cubit.emitGemWithToken(token),
        onFetchFailed: (failure) {},
      ),
    );
  }
}
