import 'package:cauth_repository/cauth_repository.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/pages/chest/widgets/_widget.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:cpub/auto_route.dart';
import 'package:cpub/flutter_bloc.dart';
import 'package:flutter/material.dart';

/// {@template CChestPage}
///
/// The initial page that displays a list of gem cards.
///
/// {@endtemplate}
@RoutePage()
class CChestPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CChestPage}
  CChestPage({
    @PathParam('chestID') required this.chestID,
    super.key,
  });

  /// The ID of the chest to display.
  final String? chestID;

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  /// Navigates to the gem page when a gem card is pressed.
  void _onGemPressed(BuildContext context, CGem gem) {
    context.router.push(CGemRoute(gemID: gem.id));
  }

  void _onChestSelected(BuildContext context, CAuthUserChest chest) {
    context.router.replace(CChestRoute(chestID: chest.id));
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
    final chests = context.read<CAuthRepository>().currentUser!.chests;
    final selectedChest = chests.firstWhere(
      (chest) => chest.id == chestID,
      orElse: () => chests.first,
    );

    return Scaffold(
      appBar: CAppBar(
        context: context,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(selectedChest.name),
            if (chests.length > 1)
              PopupMenuButton(
                icon: const Icon(Icons.arrow_drop_down_rounded),
                itemBuilder: (context) {
                  return chests
                      .map(
                        (chest) => PopupMenuItem(
                          onTap: () => _onChestSelected(context, chest),
                          child: Text(chest.name),
                        ),
                      )
                      .toList();
                },
              ),
          ],
        ),
      ),
      body: ListView.separated(
        addAutomaticKeepAlives: false,
        padding: const EdgeInsets.all(12),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) => CGemCard(
          gem: _gem,
          onPressed: (gem) => _onGemPressed(context, gem),
        ),
        itemCount: 20,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_rounded),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.diamond_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks_outlined),
            label: 'Collections',
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
    );
  }
}
