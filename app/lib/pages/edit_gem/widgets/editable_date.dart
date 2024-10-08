import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/edit_gem/logic/_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CEditableDate}
///
/// A tile on the edit gem page that allows the user to edit the `occurred at`
/// date of the gem.
///
/// {@endtemplate}
class CEditableDate extends StatelessWidget {
  /// {@macro CEditableDate}
  const CEditableDate({
    required this.occurredAt,
    super.key,
  });

  /// The date of the gem.
  final DateTime occurredAt;

  Future<void> _onTap(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: occurredAt,
    );

    if (context.mounted && date != null) {
      context.read<CGemEditCubit>().updateOccurredAt(occurredAt: date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 16,
      leading: const Icon(Icons.calendar_today_rounded),
      title: Text(context.cAppL10n.editGemPage_dateTile_title),
      subtitle: Text(occurredAt.cLocalize(context)),
      onTap: () => _onTap(context),
    );
  }
}
