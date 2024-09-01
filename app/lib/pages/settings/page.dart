import 'package:cpub/auto_route.dart';
import 'package:flutter/material.dart';

/// {@template CSettingsPage}
///
/// The settings page.
///
/// {@endtemplate}
@RoutePage()
class CSettingsPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CSettingsPage}
  const CSettingsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
