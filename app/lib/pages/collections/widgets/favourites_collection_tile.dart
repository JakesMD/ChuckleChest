import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:flutter/material.dart';

/// {@template CFavouritesCollectionTile}
///
/// The tile for the favourites collection on the collections page.
///
/// {@endtemplate}
class CFavouritesCollectionTile extends StatelessWidget {
  /// {@macro CFavouritesCollectionTile}
  const CFavouritesCollectionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 16,
      leading: const Icon(Icons.favorite_rounded),
      title: Text(context.cAppL10n.collectionsPage_collection_favourites),
      onTap: () => context.router.push(const CFavouritesCollectionRoute()),
    );
  }
}
