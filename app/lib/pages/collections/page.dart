import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/collections/logic/_logic.dart';
import 'package:chuckle_chest/pages/collections/widgets/_widgets.dart';
import 'package:chuckle_chest/pages/home/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CCollectionsPage}
///
/// One of the tabs in the home page used to display the varient collections
/// of the current chest.
///
/// This includes year collecions and the recents collection.
///
/// {@endtemplate}
@RoutePage()
class CCollectionsPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CCollectionsPage}
  const CCollectionsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CGemYearsFetchCubit(
        gemRepository: context.read(),
        chestID: context.read<CCurrentChestCubit>().state.id,
      )..fetchGemYears(),
      child: this,
    );
  }

  Future<void> _onRefresh(BuildContext context) =>
      context.read<CGemYearsFetchCubit>().fetchGemYears();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CHomePageAppBarTitle()),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(context),
        child: CResponsiveListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          children: [
            Text(
              context.cAppL10n.collectionsPage_section_title_years,
              style: context.cTextTheme.titleSmall,
            ),
            const SizedBox(height: 16),
            const CYearCollectionsSection(),
            const SizedBox(height: 48),
            Text(
              context.cAppL10n.collectionsPage_section_title_other,
              style: context.cTextTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            const CRecentsCollectionTile(),
            const CRandomCollectionTile(),
          ],
        ),
      ),
    );
  }
}
