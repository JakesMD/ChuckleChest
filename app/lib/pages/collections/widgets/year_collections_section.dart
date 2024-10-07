import 'package:auto_route/auto_route.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/pages/collections/bloc/gem_years_fetch/bloc.dart';
import 'package:chuckle_chest/shared/bloc/_bloc.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signed_spacing_flex/signed_spacing_flex.dart';
import 'package:transparent_image/transparent_image.dart';

/// {@template CYearCollectionsSection}
///
/// The section for displaying the collections for each year on the collections
/// page.
///
/// {@endtemplate}
class CYearCollectionsSection extends StatelessWidget {
  /// {@macro CYearCollectionsSection}
  const CYearCollectionsSection({super.key});

  void _onCardPressed(BuildContext context, int year) =>
      context.router.push(CYearCollectionRoute(year: year));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CGemYearsFetchBloc, CGemYearsFetchState>(
      builder: (context, state) => switch (state) {
        CGemYearsFetchInProgress() => const Center(
            child: CCradleLoadingIndicator(),
          ),
        CGemYearsFetchFailure() => const Center(
            child: Icon(Icons.error_rounded),
          ),
        CGemYearsFetchSuccess(years: final years) => Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 8,
            runSpacing: 8,
            children: years
                .map(
                  (year) => _CYearCollectionCard(
                    year: year,
                    onCardPressed: _onCardPressed,
                  ),
                )
                .toList(),
          ),
      },
    );
  }
}

class _CYearCollectionCard extends StatelessWidget {
  const _CYearCollectionCard({
    required this.year,
    required this.onCardPressed,
  });

  final int year;

  final void Function(BuildContext context, int year) onCardPressed;

  @override
  Widget build(BuildContext context) {
    final people = context.read<CChestPeopleFetchBloc>().state.people;

    final avatars = people
        .map((p) => p.avatarURLForDate(DateTime(year)))
        .where((a) => a != null)
        .toList()
        .cast<String>()
      ..shuffle();

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => onCardPressed(context, year),
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
                          final avatar =
                              avatars.length > index ? avatars[index] : null;

                          return Expanded(
                            child: ColoredBox(
                              color: context.cColorScheme.secondaryContainer,
                              child: avatar != null
                                  ? FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
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
  }
}
