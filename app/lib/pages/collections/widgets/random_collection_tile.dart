import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:flutter/material.dart';

/// {@template CRandomCollectionTile}
///
/// The tile for the random collection on the collections page.
///
/// {@endtemplate}
class CRandomCollectionTile extends StatelessWidget {
  /// {@macro CRandomCollectionTile}
  const CRandomCollectionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.casino_rounded),
      title: Text(context.cAppL10n.collectionsPage_collection_random),
      onTap: () => context.router.push(const CRandomCollectionRoute()),
    );
  }
}
