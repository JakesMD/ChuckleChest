import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/app/_app.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'app_flavor.dart';

/// {@template ChuckleChestApp}
///
/// The main application widget for the ChuckleChest app.
///
/// This widget is responsible for setting up the application theme,
/// routing and localization.
///
/// {@endtemplate}
class ChuckleChestApp extends StatelessWidget {
  /// {@macro ChuckleChestApp}
  ChuckleChestApp({
    required this.flavor,
    required BuildContext dependencyContext,
    super.key,
  }) : _appRouter = CAppRouter(dependencyContext: dependencyContext);

  /// The flavor of the app.
  final CAppFlavor flavor;

  final CAppRouter _appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CAppSettingsCubit, CAppSettingsState>(
      builder: (context, state) => MaterialApp.router(
        title: 'ChuckleChest',
        debugShowCheckedModeBanner: false,
        theme: CAppTheme.theme,
        darkTheme: CAppTheme.darkTheme,
        themeMode: state.themeMode,
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: PointerDeviceKind.values.toSet(),
        ),
        localizationsDelegates: const [
          CCoreL10n.delegate,
          ...CAppL10n.localizationsDelegates,
        ],
        supportedLocales: const [
          Locale('en', 'GB'),
          Locale('de'),
          Locale('en', 'US'),
        ],
        locale: state.locale,
        routerConfig: _appRouter.configure(),
        builder: (context, child) => Column(
          children: [
            CStagingBanner(appFlavor: flavor),
            if (child != null) Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
