import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// {@template CSettingsPage}
///
/// A tab in the home page used to display the settings of the app.
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
