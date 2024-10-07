import 'package:auto_route/auto_route.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_gem/dialogs/_dialogs.dart';
import 'package:chuckle_chest/pages/edit_gem/logic/_logic.dart';
import 'package:chuckle_chest/pages/edit_gem/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/_shared.dart';
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
  const CEditGemPage({required this.gem, super.key});

  /// The gem to edit.
  ///
  /// If `null`, a new gem will be created.
  final CGem? gem;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CGemEditCubit>(
          create: (context) => CGemEditCubit(
            gem: gem,
            chestID: context.read<CCurrentChestCubit>().state.id,
          ),
        ),
        BlocProvider<CGemSaveCubit>(
          create: (context) => CGemSaveCubit(gemRepository: context.read()),
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
        cubit: context.read(),
        occurredAt: gem.occurredAt,
        people: context.read<CChestPeopleFetchCubit>().state.people,
      ).show(context);
    } else {
      CEditNarrationDialog(
        line: line,
        index: index,
        cubit: context.read(),
      ).show(context);
    }
  }

  void _onLineDeletePressed(BuildContext context, int index) =>
      context.read<CGemEditCubit>().deleteLastLine();

  void _onSaved(BuildContext context, String gemID) {
    if (gem == null) {
      context.router.replace(CGemRoute(gemID: gemID));
      return;
    }
    context.router.maybePop(gem);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CGemSaveCubit, CGemSaveState>(
      listener: (context, state) => switch (state.status) {
        CRequestCubitStatus.initial => null,
        CRequestCubitStatus.inProgress => null,
        CRequestCubitStatus.failed => const CErrorSnackBar().show(context),
        CRequestCubitStatus.succeeded => _onSaved(context, state.gemID),
      },
      child: Scaffold(
        appBar: CAppBar(
          context: context,
          title: Text(
            gem == null
                ? context.cAppL10n.editGemPage_title_create
                : context.cAppL10n.editGemPage_title_edit,
          ),
        ),
        body: BlocBuilder<CGemEditCubit, CGemEditState>(
          builder: (context, state) => ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 80),
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
