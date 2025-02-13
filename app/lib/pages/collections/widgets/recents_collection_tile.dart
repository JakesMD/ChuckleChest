import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:flutter/material.dart';

/// {@template CRecentsCollectionTile}
///
/// The tile for the recents collection on the collections page.
///
/// {@endtemplate}
class CRecentsCollectionTile extends StatelessWidget {
  /// {@macro CRecentsCollectionTile}
  const CRecentsCollectionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.more_time_rounded),
      title: Text(context.cAppL10n.collectionsPage_collection_recents),
      onTap: () => context.router.push(const CRecentsCollectionRoute()),
    );
  }
}
