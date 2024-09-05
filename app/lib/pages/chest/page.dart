import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/bloc/_bloc.dart';
import 'package:chuckle_chest/shared/cubit/_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: BlocProvider(
        create: (context) => CChestPeopleFetchBloc(
          personRepository: context.read(),
          chestID: context.read<CCurrentChestCubit>().state.id,
        ),
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CChestPeopleFetchBloc, CChestPeopleFetchState>(
      builder: (context, state) {
        if (state is CChestPeopleFetchFailure) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(context.cAppL10n.snackBar_error_defaultMessage),
              ),
            ),
          );
        }
        if (state is CChestPeopleFetchSuccess) return const AutoRouter();
        return Container();
      },
    );
  }
}
