import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_gem/bloc/gem_edit/bloc.dart';
import 'package:chuckle_chest/pages/edit_gem/dialogs/edit_narration.dart';
import 'package:chuckle_chest/pages/edit_gem/dialogs/edit_quote.dart';
import 'package:chuckle_chest/shared/bloc/_bloc.dart';
import 'package:chuckle_chest/shared/widgets/avatar.dart';
import 'package:cpub/flutter_bloc.dart';
import 'package:flutter/material.dart';

/// {@template CEditableLine}
///
/// A widget for editing a line in a gem.
///
/// {@endtemplate}
class CEditableLine extends StatelessWidget {
  /// {@macro CEditableLine}
  const CEditableLine({
    required this.line,
    required this.index,
    required this.occurredAt,
    this.isDeleteEnabled = false,
    super.key,
  });

  /// The line to edit.
  final CLine line;

  /// The index of the line.
  final int index;

  /// The date the gem occurred at.
  final DateTime occurredAt;

  /// Whether the delete button is enabled.
  final bool isDeleteEnabled;

  @override
  Widget build(BuildContext context) {
    if (line.isQuote) {
      return _CEditableQuote(
        line: line,
        index: index,
        isDeleteEnabled: isDeleteEnabled,
        occurredAt: occurredAt,
      );
    }
    return _CEditableNarration(
      line: line,
      index: index,
      isDeleteEnabled: isDeleteEnabled,
    );
  }
}

class _CEditableNarration extends StatelessWidget {
  const _CEditableNarration({
    required this.line,
    required this.index,
    required this.isDeleteEnabled,
  });

  final CLine line;

  final int index;

  final bool isDeleteEnabled;

  void _onPressed(BuildContext context) => CEditNarrationDialog(
        line: line,
        index: index,
        bloc: context.read(),
      ).show(context);

  void _onDeletePressed(BuildContext context) =>
      context.read<CGemEditBloc>().add(CGemEditLastLineDeleted());

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 16,
      title: Text(line.text),
      onTap: () => _onPressed(context),
      trailing: isDeleteEnabled
          ? IconButton(
              onPressed: () => _onDeletePressed(context),
              icon: const Icon(Icons.close_rounded),
            )
          : null,
    );
  }
}

class _CEditableQuote extends StatelessWidget {
  const _CEditableQuote({
    required this.line,
    required this.index,
    required this.occurredAt,
    this.isDeleteEnabled = false,
  });

  final CLine line;

  final int index;

  final DateTime occurredAt;

  final bool isDeleteEnabled;

  void _onPressed(BuildContext context) => CEditQuoteDialog(
        line: line,
        index: index,
        bloc: context.read(),
        occurredAt: occurredAt,
        people: context.read<CChestPeopleFetchBloc>().state.people,
      ).show(context);

  void _onDeletePressed(BuildContext context) =>
      context.read<CGemEditBloc>().add(CGemEditLastLineDeleted());

  @override
  Widget build(BuildContext context) {
    final people = context.read<CChestPeopleFetchBloc>().state.people;
    final person = people.firstWhere((person) => person.id == line.personID);

    return ListTile(
      minVerticalPadding: 16,
      leading: CAvatar(personID: person.id, date: occurredAt),
      titleTextStyle: Theme.of(context).textTheme.labelMedium,
      subtitleTextStyle: Theme.of(context).textTheme.bodyLarge,
      title: Text(
        context.cAppL10n.quoteItem_person(
          person.nickname,
          person.ageAtDate(occurredAt),
        ),
      ),
      subtitle: Text(line.text),
      onTap: () => _onPressed(context),
      titleAlignment: ListTileTitleAlignment.top,
      trailing: isDeleteEnabled
          ? IconButton(
              onPressed: () => _onDeletePressed(context),
              icon: const Icon(Icons.close_rounded),
            )
          : null,
    );
  }
}
