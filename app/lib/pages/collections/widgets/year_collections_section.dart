import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/collections/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
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
    return BlocBuilder<CGemYearsFetchCubit, CGemYearsFetchState>(
      buildWhen: (_, state) => !state.inProgress,
      builder: (context, state) => switch (state.status) {
        CRequestCubitStatus.initial =>
          const Center(child: CCradleLoadingIndicator()),
        CRequestCubitStatus.inProgress =>
          const Center(child: CCradleLoadingIndicator()),
        CRequestCubitStatus.failed =>
          const Center(child: Icon(Icons.error_rounded)),
        CRequestCubitStatus.succeeded => state.years.isNotEmpty
            ? Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 8,
                runSpacing: 8,
                children: state.years
                    .map(
                      (year) => _CYearCollectionCard(
                        year: year,
                        onCardPressed: _onCardPressed,
                      ),
                    )
                    .toList(),
              )
            : Center(
                child: Text(
                  context.cAppL10n.collectionsPage_noGemsMessage,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
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
    final people = context.read<CChestPeopleFetchCubit>().state.people;

    final avatars = people
        .map((p) => p.avatarURLForDate(DateTime(year))?.url)
        .where((a) => a != null)
        .toList()
        .cast<String>()
      ..shuffle();

    return Card.filled(
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
                              color: context.cColorScheme.surfaceContainer,
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
