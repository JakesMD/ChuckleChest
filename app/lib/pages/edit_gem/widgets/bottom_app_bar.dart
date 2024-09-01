import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_gem/bloc/gem_edit/bloc.dart';
import 'package:chuckle_chest/pages/edit_gem/dialogs/edit_narration.dart';
import 'package:chuckle_chest/pages/edit_gem/dialogs/edit_quote.dart';
import 'package:chuckle_chest/shared/bloc/_bloc.dart';
import 'package:cpub/flutter_bloc.dart';
import 'package:cpub/signed_spacing_flex.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: SignedSpacingRow(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextButton.icon(
              onPressed: () =>
                  CEditNarrationDialog(bloc: context.read()).show(context),
              icon: const Icon(Icons.menu_book_rounded),
              label: Text(context.cAppL10n.editGemPage_addNarrationButton),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              onPressed: () => CEditQuoteDialog(
                bloc: context.read(),
                occurredAt: context.read<CGemEditBloc>().state.gem.occurredAt,
                people: context.read<CChestPeopleFetchBloc>().state.people,
              ).show(context),
              icon: const Icon(Icons.message_rounded),
              label: Text(context.cAppL10n.editGemPage_addQuoteButton),
            ),
          ),
        ],
      ),
    );
  }
}
