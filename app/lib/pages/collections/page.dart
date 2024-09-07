import 'package:auto_route/auto_route.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/pages/collections/bloc/gem_years_fetch/bloc.dart';
import 'package:chuckle_chest/shared/bloc/_bloc.dart';
import 'package:chuckle_chest/shared/cubit/_cubit.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signed_spacing_flex/signed_spacing_flex.dart';
import 'package:transparent_image/transparent_image.dart';

/// {@template CCollectionsPage}
///
/// The page for displaying all the collections.
///
/// {@endtemplate}
@RoutePage()
class CCollectionsPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CCollectionsPage}
  const CCollectionsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CGemYearsFetchBloc(
        gemRepository: context.read(),
        chestID: context.read<CCurrentChestCubit>().state.id,
      ),
      child: this,
    );
  }

  void _onCardPressed(BuildContext context, int year) {
    context.router.push(CCollectionRoute(year: year));
  }

  @override
  Widget build(BuildContext context) {
    final people = context.read<CChestPeopleFetchBloc>().state.people;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        BlocBuilder<CGemYearsFetchBloc, CGemYearsFetchState>(
          builder: (context, state) => switch (state) {
            CGemYearsFetchInProgress() => const Center(
                child: CCradleLoadingIndicator(),
              ),
            CGemYearsFetchFailure() => const Center(
                child: Icon(Icons.error_rounded),
              ),
            CGemYearsFetchSuccess(years: final years) => Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: years.map(
                  (year) {
                    final avatars = people
                        .map((p) => p.avatarURLForDate(DateTime(year)))
                        .where((a) => a != null)
                        .toList()
                        .cast<String>()
                      ..shuffle();

                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () => _onCardPressed(context, year),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 160,
                              height: 160,
                              child: SignedSpacingColumn(
                                spacing: 4,
                                children: List.generate(
                                  2,
                                  (col) => Expanded(
                                    child: SignedSpacingRow(
                                      spacing: 4,
                                      children: List.generate(
                                        2,
                                        (row) {
                                          final index = col * 2 + row;
                                          final avatar = avatars.length > index
                                              ? avatars[index]
                                              : null;

                                          return Expanded(
                                            child: ColoredBox(
                                              color: context.cColorScheme
                                                  .secondaryContainer,
                                              child: avatar != null
                                                  ? FadeInImage.memoryNetwork(
                                                      placeholder:
                                                          kTransparentImage,
                                                      image: avatar,
                                                    )
                                                  : Container(),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                year.toString(),
                                style: context.cTextTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
          },
        ),
      ],
    );
  }
}
