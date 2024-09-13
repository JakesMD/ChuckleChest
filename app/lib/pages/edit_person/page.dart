import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:flutter/material.dart';

/// {@template CEditPersonPage}
///
/// The page that allows the user to edit person data.
///
/// {@endtemplate}
@RoutePage()
class CEditPersonPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CEditPersonPage}
  const CEditPersonPage({
    required this.person,
    super.key,
  });

  /// The person to edit.
  final CPerson person;

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        context: context,
        title: const Text('Edit Person'),
      ),
    );
  }
}
