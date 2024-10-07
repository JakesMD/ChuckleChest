import 'package:auto_route/auto_route.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/collections/bloc/gem_years_fetch/bloc.dart';
import 'package:chuckle_chest/pages/collections/widgets/year_collections_section.dart';
import 'package:chuckle_chest/shared/cubit/_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          context.cAppL10n.collectionsPage_section_title_years,
          style: context.cTextTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        const CYearCollectionsSection(),
        const SizedBox(height: 48),
        Text(
          context.cAppL10n.collectionsPage_section_title_other,
          style: context.cTextTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.more_time_rounded),
          title: Text(context.cAppL10n.collectionsPage_collection_recents),
          onTap: () => context.router.push(const CRecentsCollectionRoute()),
        ),
      ],
    );
  }
}
