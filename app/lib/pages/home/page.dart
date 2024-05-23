import 'dart:math';

import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/pages/home/widgets/_widget.dart';
import 'package:cpub/auto_route.dart';
import 'package:cpub/scrollable_positioned_list.dart';
import 'package:flutter/material.dart';

/// {@template CHomePage}
///
/// The initial page that displays a list of gem cards.
///
/// {@endtemplate}
@RoutePage()
class CHomePage extends StatefulWidget implements AutoRouteWrapper {
  /// {@macro CHomePage}
  const CHomePage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  /// Navigates to the gem page when a gem card is pressed.
  void onGemPressed(BuildContext context, CGem gem) {
    context.router.push(CGemRoute(gemID: gem.id));
  }

  @override
  State<CHomePage> createState() => _CHomePageState();
}

class _CHomePageState extends State<CHomePage> {
  late ItemPositionsListener itemPositionsListener;
  late ColorScheme newColorScheme;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    itemPositionsListener = ItemPositionsListener.create();
    itemPositionsListener.itemPositions.addListener(onNewGemVisible);

    generateNewColorScheme();
  }

  void onNewGemVisible() {
    final newIndex = itemPositionsListener.itemPositions.value.first.index;

    if (newIndex != currentIndex) {
      generateNewColorScheme();
      setState(() => currentIndex = newIndex);
    }
  }

  void generateNewColorScheme() {
    newColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    );
  }

  @override
  Widget build(BuildContext context) {
    final gem = CGem(
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

    return Theme(
      data: Theme.of(context).copyWith(colorScheme: newColorScheme),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ChuckleChest'),
          centerTitle: true,
          backgroundColor: newColorScheme.inversePrimary,
        ),
        body: ScrollablePositionedList.separated(
          addAutomaticKeepAlives: false,
          padding: const EdgeInsets.all(12),
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) => CGemCard(
            gem: gem,
            onPressed: (gem) => widget.onGemPressed(context, gem),
          ),
          itemCount: 20,
          itemPositionsListener: itemPositionsListener,
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
              label: 'Connections',
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
