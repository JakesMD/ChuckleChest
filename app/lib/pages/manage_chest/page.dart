import 'package:auto_route/auto_route.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/manage_chest/logic/_logic.dart';
import 'package:chuckle_chest/pages/manage_chest/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signed_spacing_flex/signed_spacing_flex.dart';

/// {@template CManageChestPage}
///
/// The page that allows the user to manage a chest by inviting, removing users,
/// changing their roles and changing the chest's name.
///
/// {@endtemplate}
@RoutePage()
class CManageChestPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CManageChestPage}
  const CManageChestPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CChestNameUpdateCubit(
            chestRepository: context.read(),
            chestID: context.read<CCurrentChestCubit>().state.id,
          ),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CChestNameUpdateCubit, CChestNameUpdateState>(
            listener: (context, state) => switch (state.status) {
              CRequestCubitStatus.initial => null,
              CRequestCubitStatus.inProgress => null,
              CRequestCubitStatus.succeeded =>
                context.read<CCurrentChestCubit>().updateName(state.name),
              CRequestCubitStatus.failed =>
                const CErrorSnackBar().show(context),
            },
          ),
        ],
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CAppBar(
        context: context,
        title: Text(context.cAppL10n.manageChestPage_title),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const CChestNameTile(),
            const TabBar(tabs: [Tab(text: 'Members'), Tab(text: 'Invited')]),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    padding: const EdgeInsets.all(8),
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SignedSpacingColumn(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            spacing: 24,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Jacob Drew',
                                      style: context.cTextTheme.titleMedium,
                                    ),
                                  ),
                                  IconButton.filledTonal(
                                    onPressed: () {},
                                    icon: const Icon(Icons.delete_rounded),
                                  ),
                                ],
                              ),
                              SegmentedButton(
                                segments: [
                                  ButtonSegment(
                                    value: CUserRole.viewer,
                                    label: Text(
                                      CUserRole.viewer.cLocalize(context),
                                    ),
                                  ),
                                  ButtonSegment(
                                    value: CUserRole.collaborator,
                                    label: Text(
                                      CUserRole.collaborator.cLocalize(context),
                                    ),
                                  ),
                                ],
                                selected: const {CUserRole.viewer},
                                onSelectionChanged: (selected) {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      ListTile(
                        minVerticalPadding: 16,
                        title: const Text('jakesmdrew@gmail.com'),
                        subtitle: const Text('Viewer'),
                        trailing: const Icon(Icons.delete_rounded),
                        onTap: () {},
                      ),
                      ListTile(
                        minVerticalPadding: 16,
                        title: const Text('jakesmdrew@gmail.com'),
                        subtitle: const Text('Viewer'),
                        trailing: const Icon(Icons.delete_rounded),
                        onTap: () {},
                      ),
                      ListTile(
                        minVerticalPadding: 16,
                        title: const Text('jakesmdrew@gmail.com'),
                        subtitle: const Text('Viewer'),
                        trailing: const Icon(Icons.delete_rounded),
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
