import 'package:auto_route/auto_route.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:flutter/material.dart';

export 'tabs/login_tab.dart';
export 'tabs/signup_tab.dart';

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
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: [
        CSignupRoute(),
        CLoginRoute(),
      ],
      builder: (context, child, controller) => Scaffold(
        appBar: CAppBar(
          context: context,
          title: Text(context.cAppL10n.signinPage_title),
          bottom: TabBar(
            controller: controller,
            tabs: [
              Tab(text: context.cAppL10n.signinPage_tab_signup),
              Tab(text: context.cAppL10n.signinPage_tab_login),
            ],
          ),
        ),
        body: child,
      ),
    );
  }
}
