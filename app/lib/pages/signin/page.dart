import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/routes.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/pages/signin/logic/login_cubit.dart';
import 'package:chuckle_chest/pages/signin/logic/signup_cubit.dart';
import 'package:chuckle_chest/pages/signin/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'tabs/_tabs.dart';

/// {@template CSigninPage}
///
/// The page that allows the user to sign in.
///
/// This page contains two tabs: one for signing up and one for logging in.
///
/// {@endtemplate}
@RoutePage()
class CSigninPage extends StatelessWidget implements AutoRouteWrapper {
  /// {@macro CSigninPage}
  const CSigninPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CSignupCubit(authRepository: context.read()),
        ),
        BlocProvider(
          create: (context) => CLoginCubit(authRepository: context.read()),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: [const CSignupRoute(), CLoginRoute()],
      builder: (context, child, controller) => Scaffold(
        appBar: CAppBar(
          context: context,
          title: Text(context.cAppL10n.signinPage_title),
          actions: const [CSettingsMenu()],
          bottom: TabBar(
            controller: controller,
            tabs: [
              Tab(text: context.cAppL10n.signinPage_tab_signup),
              Tab(text: context.cAppL10n.signinPage_tab_login),
            ],
          ),
        ),
        body: Column(
          children: [
            CAppBarLoadingIndicator(
              listeners: [
                CLoadingListener<CSignupCubit, CSignupState>(),
                CLoadingListener<CLoginCubit, CLoginState>(),
              ],
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
