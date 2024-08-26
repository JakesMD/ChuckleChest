import 'package:flutter/material.dart';

/// A mixin that provides a `show` method to show a dialog.
mixin CDialogMixin on StatelessWidget {
  /// Builds and displays the dialog.
  Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: build,
    );
  }
}
