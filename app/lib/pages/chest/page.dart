import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CChestPage}
///
/// The page that selected chest with the given `chestID` and fetches its
/// people.
///
/// If the `chestID` is null, the first chest the user has access to will
/// selected.
///
/// Only after the people have been fetched will the user be navigated to the
/// [AutoRouter].
///
/// {@endtemplate}
@RoutePage()
class CChestPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CChestPage}
  const CChestPage({this.chestID, super.key});

  /// The ID of the chest to select.
  final String? chestID;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      key: UniqueKey(),
      lazy: false,
      create: (context) => CCurrentChestCubit(
        chestID: chestID,
        lastViewedChest:
            context.read<CAppSettingsCubit>().state.lastViewedChest,
        authRepository: context.read(),
      ),
      child: BlocProvider(
        create: (context) => CChestPeopleFetchCubit(
          personRepository: context.read(),
        )..fetchChestPeople(
            chestID: context.read<CCurrentChestCubit>().state.id,
          ),
        child: BlocListener<CChestPeopleFetchCubit, CChestPeopleFetchState>(
          listener: (context, _) =>
              context.read<CAppSettingsCubit>().updateLastViewedChest(
                    context.read<CCurrentChestCubit>().state.id,
                  ),
          listenWhen: (_, state) => state.succeeded,
          child: this,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CChestPeopleFetchCubit, CChestPeopleFetchState>(
      builder: (context, state) {
        if (state.status == CRequestCubitStatus.failed) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(context.cAppL10n.snackBar_error_defaultMessage),
              ),
            ),
          );
        }
        if (state.status == CRequestCubitStatus.succeeded) {
          return const AutoRouter();
        }
        return Scaffold(
          body: Center(
            child: CCradleLoadingIndicator(color: context.cColorScheme.primary),
          ),
        );
      },
    );
  }
}
