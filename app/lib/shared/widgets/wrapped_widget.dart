import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// {@template CWrappedWidget}
///
/// A custom widget with a wrapper around the [builder] method.
///
/// This is useful when you want to wrap the widget with a BlocProvider or
/// BlocListener.
///
/// {@endtemplate}
abstract class CWrappedWidget extends StatelessWidget {
  /// {@macro CWrappedWidget}
  const CWrappedWidget({super.key});

  /// Wraps the [builder] method with a custom widget.
  @mustBeOverridden
  Widget wrapper(BuildContext context) {
    return builder(context);
  }

  /// The main widget to build.
  @mustBeOverridden
  Widget builder(BuildContext context) {
    return const Placeholder();
  }

  @override
  @nonVirtual
  Widget build(BuildContext context) {
    return wrapper(context);
  }
}
