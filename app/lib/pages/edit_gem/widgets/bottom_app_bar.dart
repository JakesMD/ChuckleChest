import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_gem/dialogs/_dialogs.dart';
import 'package:chuckle_chest/pages/edit_gem/logic/_logic.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signed_spacing_flex/signed_spacing_flex.dart';

/// {@template CEditGemPageBottomAppBar}
///
/// The bottom app bar for the gem page.
///
/// Contains buttons for adding a narration and a quote.
///
/// {@endtemplate}
class CEditGemPageBottomAppBar extends StatelessWidget {
  /// {@macro CEditGemPageBottomAppBar}
  const CEditGemPageBottomAppBar({super.key});

  void _onAddNarrationPressed(BuildContext context) =>
      CEditNarrationDialog(cubit: context.read()).show(context);

  void _onAddQuotePressed(BuildContext context) => CEditQuoteDialog(
        cubit: context.read(),
        occurredAt: context.read<CGemEditCubit>().state.gem.occurredAt,
        people: context.read<CChestPeopleFetchCubit>().state.people,
      ).show(context);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SignedSpacingRow(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextButton.icon(
              onPressed: () => _onAddNarrationPressed(context),
              icon: const Icon(Icons.menu_book_rounded),
              label: Text(context.cAppL10n.editGemPage_addNarrationButton),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              onPressed: () => _onAddQuotePressed(context),
              icon: const Icon(Icons.message_rounded),
              label: Text(context.cAppL10n.editGemPage_addQuoteButton),
            ),
          ),
        ],
      ),
    );
  }
}
