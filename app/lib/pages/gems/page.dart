import 'package:cpub/auto_route.dart';
import 'package:flutter/material.dart';

/// {@template CGemsPage}
///
/// The page for displaying the gems.
///
/// {@endtemplate}
@RoutePage()
class CGemsPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CGemsPage}
  const CGemsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
