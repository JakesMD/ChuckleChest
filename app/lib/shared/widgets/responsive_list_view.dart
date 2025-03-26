import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';

/// {@template CResponsiveListView}
///
/// A list view that adjusts its padding based on the available width.
///
/// The scrollable area will fill the available width while constraining the
/// content to a maximum width of 500.
///
/// {@endtemplate}
class CResponsiveListView<T> extends StatelessWidget {
  /// {@macro CResponsiveListView}
  const CResponsiveListView({
    required List<Widget> children,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
    this.controller,
    super.key,
  })  : _children = children,
        _items = null,
        _itemBuilder = null,
        _separatorBuilder = null;

  /// {@macro CResponsiveListView}
  const CResponsiveListView.builder({
    required List<T> items,
    required Widget Function(BuildContext, T) itemBuilder,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
    this.controller,
    super.key,
  })  : _items = items,
        _itemBuilder = itemBuilder,
        _separatorBuilder = null,
        _children = null;

  /// {@macro CResponsiveListView}
  const CResponsiveListView.separated({
    required List<T> items,
    required Widget Function(BuildContext, T) itemBuilder,
    required Widget Function(BuildContext) separatorBuilder,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
    this.controller,
    super.key,
  })  : _items = items,
        _itemBuilder = itemBuilder,
        _separatorBuilder = separatorBuilder,
        _children = null;

  /// The children to display in a normal list view.
  final List<Widget>? _children;

  /// The items to display in a builder list view.
  final List<T>? _items;

  /// The builder to use for the builder list view.
  final Widget Function(BuildContext, T)? _itemBuilder;

  /// The builder to use for the builder list view.
  final Widget Function(BuildContext)? _separatorBuilder;

  /// The padding to apply to the list view.
  final EdgeInsets padding;

  /// The scroll controller to use for the list view.
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return CResponsivePadding(
      padding: padding,
      builder: (context, padding) {
        if (_children != null) {
          return ListView(
            controller: controller,
            padding: padding,
            children: _children,
          );
        }

        if (_separatorBuilder != null) {
          return ListView.separated(
            controller: controller,
            padding: padding,
            itemCount: _items!.length,
            itemBuilder: (context, index) =>
                _itemBuilder!(context, _items[index]),
            separatorBuilder: (context, index) => _separatorBuilder(context),
          );
        }

        return ListView.builder(
          controller: controller,
          padding: padding,
          itemCount: _items!.length,
          itemBuilder: (context, index) =>
              _itemBuilder!(context, _items[index]),
        );
      },
    );
  }
}
