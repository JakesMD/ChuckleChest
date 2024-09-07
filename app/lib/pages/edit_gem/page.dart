import 'package:auto_route/auto_route.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_gem/bloc/gem_edit/bloc.dart';
import 'package:chuckle_chest/pages/edit_gem/bloc/gem_save/bloc.dart';
import 'package:chuckle_chest/pages/edit_gem/dialogs/edit_narration.dart';
import 'package:chuckle_chest/pages/edit_gem/dialogs/edit_quote.dart';
import 'package:chuckle_chest/pages/edit_gem/widgets/bottom_app_bar.dart';
import 'package:chuckle_chest/pages/edit_gem/widgets/editable_date.dart';
import 'package:chuckle_chest/pages/edit_gem/widgets/save_fab.dart';
import 'package:chuckle_chest/shared/bloc/_bloc.dart';
import 'package:chuckle_chest/shared/cubit/_cubit.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CEditGemPage}
///
/// The page for editing or creating a gem.
///
/// {@endtemplate}
@RoutePage()
class CEditGemPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CEditGemPage}
  const CEditGemPage({super.key, this.isNewGem = false});

  /// Whether the gem is new and should be created.
  final bool isNewGem;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CGemEditBloc>(
          create: (context) => CGemEditBloc(
            gemRepository: context.read(),
            gem: null,
            chestID: context.read<CCurrentChestCubit>().state.id,
          ),
        ),
        BlocProvider<CGemSaveBloc>(
          create: (context) => CGemSaveBloc(gemRepository: context.read()),
        ),
      ],
      child: this,
    );
  }

  void _onLinePressed(BuildContext context, CGem gem, int index) {
    final line = gem.lines[index];

    if (line.isQuote) {
      CEditQuoteDialog(
        line: line,
        index: index,
        bloc: context.read(),
        occurredAt: gem.occurredAt,
        people: context.read<CChestPeopleFetchBloc>().state.people,
      ).show(context);
    } else {
      CEditNarrationDialog(
        line: line,
        index: index,
        bloc: context.read(),
      ).show(context);
    }
  }

  void _onLineDeletePressed(BuildContext context, int index) {
    context.read<CGemEditBloc>().add(CGemEditLastLineDeleted());
  }

  void _onSaved(BuildContext context, String gemID) {
    context.router.replace(CGemRoute(gemID: gemID));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CGemSaveBloc, CGemSaveState>(
      listener: (context, state) => switch (state) {
        CGemSaveInitial() => null,
        CGemSaveInProgress() => null,
        CGemSaveFailure() => const CErrorSnackBar().show(context),
        CGemSaveSuccess(gemID: final gemID) => _onSaved(context, gemID),
      },
      child: Scaffold(
        appBar: CAppBar(
          context: context,
          title: Text(
            isNewGem
                ? context.cAppL10n.editGemPage_title_create
                : context.cAppL10n.editGemPage_title_edit,
          ),
        ),
        body: BlocBuilder<CGemEditBloc, CGemEditState>(
          builder: (context, state) => ListView(
            padding: const EdgeInsets.symmetric(vertical: 12),
            children: [
              Text(
                context.cAppL10n.editGemPage_helperMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              CEditableDate(occurredAt: state.gem.occurredAt),
              const Divider(height: 48),
              ...List.generate(
                state.gem.lines.length,
                (index) => CAnimatedLine(
                  line: state.gem.lines[index],
                  occurredAt: state.gem.occurredAt,
                  isDeleteEnabled: index == state.gem.lines.length - 1,
                  isAnimated: false,
                  onPressed: () => _onLinePressed(context, state.gem, index),
                  onDeletePressed: () => _onLineDeletePressed(context, index),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CEditGemPageBottomAppBar(),
        floatingActionButton: const CSaveGemFAB(),
      ),
    );
  }
}
