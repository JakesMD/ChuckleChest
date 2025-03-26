import 'package:flutter/material.dart';

/// {@template CResponsivePadding}
///
/// A builder that provides a responsive padding to its child.
///
/// This is required for list views to be scollable outside of their designated
/// width.
///
/// {@endtemplate}
class CResponsivePadding extends StatelessWidget {
  /// {@macro CResponsivePadding}
  const CResponsivePadding({
    required this.builder,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
    super.key,
  });

  /// The preferred padding to apply to the child.
  final EdgeInsets padding;

  /// The builder providing the padding to apply to the child.
  final Widget Function(BuildContext context, EdgeInsets padding) builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = constraints.maxWidth < 500
            ? null
            : (constraints.maxWidth - 500) / 2.0;

        final listPadding = EdgeInsets.fromLTRB(
          horizontalPadding ?? padding.left,
          padding.top,
          horizontalPadding ?? padding.right,
          padding.bottom,
        );

        return builder(context, listPadding);
      },
    );
  }
}
