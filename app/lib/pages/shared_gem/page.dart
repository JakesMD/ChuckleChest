import 'package:auto_route/auto_route.dart';
import 'package:ccore/ccore.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CSharedGemPage}
///
/// The page for viewing a shared gem.
///
/// {@endtemplate}
@RoutePage()
class CSharedGemPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CSharedGemPage}
  const CSharedGemPage({
    @QueryParam('token') required this.shareToken,
    super.key,
  });

  /// The token for the shared gem.
  final String? shareToken;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CGemFetchFromShareTokenCubit(
        gemRepository: context.read(),
      ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CCollectionView<
          CGemFetchFromShareTokenCubit,
          CGemFetchFromShareTokenState,
          CGemFetchFromShareTokenException,
          CSharedGem>(
        gemTokens: [shareToken ?? ''],
        userRole: CUserRole.viewer,
        gemFromState: (state) => state.gem,
        gemTokenFromState: (state) => shareToken ?? '',
        triggerFetchGem: (context, token) => context
            .read<CGemFetchFromShareTokenCubit>()
            .fetchGem(shareToken: token),
        onFetchFailed: (failure) => switch (failure) {
          CGemFetchFromShareTokenException.unknown =>
            const CErrorSnackBar().show(context),
        },
      ),
    );
  }
}
