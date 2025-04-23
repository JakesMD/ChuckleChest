import 'package:auto_route/auto_route.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:chuckle_chest/pages/home/widgets/_widgets.dart';
import 'package:chuckle_chest/pages/settings/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CSignoutCubit(authRepository: context.read()),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<CSignoutCubit, CSignoutState>(
            listener: (context, state) => const CErrorSnackBar().show(context),
            listenWhen: (_, state) => state.failed,
          ),
        ],
        child: this,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isOwner = context.currentChest.isUserOwner;

    return Scaffold(
      appBar: AppBar(title: const CHomePageAppBarTitle()),
      body: CResponsiveListView(
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 32),
        children: [
          if (isOwner) const CManageChestTile(),
          if (isOwner) const Divider(height: 16),
          const CInvitationsTile(),
          const CCreateChestTile(),
          const Divider(height: 16),
          const CLanguageTile(),
          const CThemeTile(),
          const Divider(height: 16),
          const CContactTile(),
          const CPrivacyPolicyTile(),
          const CTermsOfServiceTile(),
          const CLicensesTile(),
          const CDemoTile(),
          const CLogsTile(),
          const Divider(height: 16),
          const SizedBox(height: 32),
          const CSignoutButton(),
        ],
      ),
    );
  }
}
