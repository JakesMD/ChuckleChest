import 'package:flutter/material.dart';

/// {@template CResponsiveListView}
///
/// A list view that adjusts its padding based on the available width.
///
/// The scrollable area will fill the available width while constraining the
/// content to a maximum width of 500.
///
///
/// {@endtemplate}
class CResponsiveListView<T> extends StatelessWidget {
  /// {@macro CResponsiveListView}
  const CResponsiveListView({
    required List<Widget> children,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
    super.key,
  })  : _children = children,
        _items = null,
        _itemBuilder = null;

  /// {@macro CResponsiveListView}
  const CResponsiveListView.builder({
    required List<T> items,
    required Widget Function(BuildContext, T) itemBuilder,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
    super.key,
  })  : _items = items,
        _itemBuilder = itemBuilder,
        _children = null;

  /// The children to display in a normal list view.
  final List<Widget>? _children;

  /// The items to display in a builder list view.
  final List<T>? _items;

  /// The builder to use for the builder list view.
  final Widget Function(BuildContext, T)? _itemBuilder;

  /// The padding to apply to the list view.
  final EdgeInsets padding;

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

        if (_children != null) {
          return ListView(
            padding: listPadding,
            children: _children,
          );
        }

        return ListView.builder(
          padding: listPadding,
          itemCount: _items!.length,
          itemBuilder: (context, index) =>
              _itemBuilder!(context, _items[index]),
        );
      },
    );
  }
}
