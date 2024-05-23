import 'package:chuckle_chest/localization/l10n.dart';
import 'package:flutter/material.dart';

/// {@template CErrorSnackBar}
///
/// A snack bar that shows an error message.
///
/// {@endtemplate}
class CErrorSnackBar {
  /// {@macro CErrorSnackBar}
  const CErrorSnackBar({this.message});

  /// The error message to display.
  ///
  /// If null, the default message will be shown.
  final String? message;

  /// Shows the snack bar.
  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(_build(context));
  }

  SnackBar _build(BuildContext context) {
    return SnackBar(
      backgroundColor: Theme.of(context).colorScheme.error,
      content: Text(
        message ?? context.cAppL10n.snackBar_error_defaultMessage,
        style: TextStyle(color: Theme.of(context).colorScheme.onError),
      ),
    );
  }
}
