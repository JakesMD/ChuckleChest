import 'package:chuckle_chest/shared/cubit/_cubit.dart';
import 'package:cpub/auto_route.dart';
import 'package:cpub/flutter_bloc.dart';
import 'package:flutter/material.dart';

/// {@template CChestPage}
///
/// The initial page that displays a list of gem cards.
///
/// {@endtemplate}
@RoutePage()
class CChestPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CChestPage}
  const CChestPage({
    @PathParam('chest-id') required this.chestID,
    super.key,
  });

  /// The ID of the chesdt to display.
  final String? chestID;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      key: UniqueKey(),
      lazy: false,
      create: (context) => CCurrentChestCubit(
        chestID: chestID,
        authRepository: context.read(),
      ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) => const AutoRouter();
}
