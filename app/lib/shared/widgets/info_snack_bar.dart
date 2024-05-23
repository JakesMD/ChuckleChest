import 'package:flutter/material.dart';

/// {@template CErrorSnackBar}
///
/// A snack bar that shows a message.
///
/// {@endtemplate}
class CInfoSnackBar {
  /// {@macro CInfoSnackBar}
  const CInfoSnackBar({required this.message});

  /// The message to display.
  final String message;

  /// Shows the snack bar.
  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(_build(context));
  }

  SnackBar _build(BuildContext context) {
    return SnackBar(content: Text(message));
  }
}
