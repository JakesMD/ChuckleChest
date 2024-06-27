import 'dart:math';

import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/pages/home/widgets/_widget.dart';
import 'package:cpub/auto_route.dart';
import 'package:flutter/material.dart';

/// {@template CHomePage}
///
/// The initial page that displays a list of gem cards.
///
/// {@endtemplate}
@RoutePage()
class CHomePage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CHomePage}
  CHomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  /// Navigates to the gem page when a gem card is pressed.
  void onGemPressed(BuildContext context, CGem gem) {
    context.router.push(CGemRoute(gemID: gem.id));
  }

  final _gem = CGem(
    id: '8a9a6685-6dce-4c94-ad0b-76b65b0ab48f',
    number: 290,
    occurredAt: DateTime.now(),
    lines: [
      CNarration(
        id: BigInt.from(1),
        text:
            '''Lydia showing Mum and Dad her outfits for the Funeral and wanting their approval.''',
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    );

    return Theme(
      data: Theme.of(context).copyWith(colorScheme: colorScheme),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ChuckleChest'),
          centerTitle: true,
          backgroundColor: colorScheme.inversePrimary,
        ),
        body: ListView.separated(
          addAutomaticKeepAlives: false,
          padding: const EdgeInsets.all(12),
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) => CGemCard(
            gem: _gem,
            onPressed: (gem) => onGemPressed(context, gem),
          ),
          itemCount: 20,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add_rounded),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.diamond_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.family_restroom_rounded),
              label: 'People',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
