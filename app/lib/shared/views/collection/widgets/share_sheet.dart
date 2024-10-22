import 'package:ccore/ccore.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/views/collection/logic/_logic.dart';
import 'package:flutter/material.dart';
import 'package:signed_spacing_flex/signed_spacing_flex.dart';

/// {@template CShareSheet}
///
/// The bottom sheet on the CCollectionView that allows the user to share the
/// gem.
///
/// It displays a button to share the gem with a link, a button to delete the
/// link, and a button to create a new link.
///
/// {@endtemplate}
class CShareSheet extends StatelessWidget {
  /// {@macro CShareSheet}
  const CShareSheet({
    required this.gem,
    required this.onShared,
    required this.shareTokenCreationCubit,
    super.key,
  });

  /// The gem to share.
  final CGem gem;

  /// Called with the share token when the gem is shared.
  final void Function(String token) onShared;

  /// The cubit that creates share tokens.
  final CGemShareTokenCreationCubit shareTokenCreationCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SignedSpacingColumn(
        spacing: 24,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (gem.shareToken != null)
            ElevatedButton.icon(
              onPressed: () {
                onShared(gem.shareToken!);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.cColorScheme.primary,
                foregroundColor: context.cColorScheme.onPrimary,
              ),
              label: Text(
                context.cAppL10n.collectionView_shareSheet_shareLinkButton,
              ),
              icon: const Icon(Icons.insert_link_rounded),
            ),
          if (gem.shareToken != null)
            OutlinedButton.icon(
              onPressed: null,
              label: Text(
                context.cAppL10n.collectionView_shareSheet_deleteLinkButton,
              ),
              icon: const Icon(Icons.delete_rounded),
            ),
          if (gem.shareToken == null)
            ElevatedButton.icon(
              onPressed: () {
                shareTokenCreationCubit.createShareToken(gemID: gem.id);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.cColorScheme.primary,
                foregroundColor: context.cColorScheme.onPrimary,
              ),
              label: Text(
                context.cAppL10n.collectionView_shareSheet_createLinkButton,
              ),
              icon: const Icon(Icons.add_link_rounded),
            ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  /// Opens the share sheet.
  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => this,
    );
  }
}
