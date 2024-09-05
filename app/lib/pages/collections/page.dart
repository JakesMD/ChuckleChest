import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// {@template CCollectionsPage}
///
/// The page for displaying all the collections.
///
/// {@endtemplate}
@RoutePage()
class CCollectionsPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CCollectionsPage}
  const CCollectionsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
