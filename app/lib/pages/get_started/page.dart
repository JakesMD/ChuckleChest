import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:cpub/auto_route.dart';
import 'package:flutter/material.dart';

/// {@template CGetStartedPage}
///
/// The page that is displayed when the user is not a member of any chests.
///
/// The user can accept an invitation to join a chest or create a new chest.
///
/// {@endtemplate}
@RoutePage()
class CGetStartedPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CGetStartedPage}
  const CGetStartedPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        context: context,
        title: const Text("Let's Get Started!"),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_rounded),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 1,
                child: Text('Log out'),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          FilledButton(
            onPressed: () {},
            child: const Text('Create a new chest'),
          ),
        ],
      ),
    );
  }
}
