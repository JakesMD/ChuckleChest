import 'package:flutter/material.dart';

/// {@template CAppBar}
///
/// A wrapper around the [AppBar] widget that applies the ChuckleChest app
/// theme.
///
/// {@endtemplate}
class CAppBar extends AppBar {
  /// {@macro CAppBar}
  CAppBar({
    required BuildContext context,
    required super.title,
    super.leading,
    super.automaticallyImplyLeading,
    super.bottom,
    super.actions,
    super.key,
  }) : super(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
        );
}
