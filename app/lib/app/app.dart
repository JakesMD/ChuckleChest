import 'dart:math';

import 'package:cauth_client/cauth_client.dart';
import 'package:cauth_repository/cauth_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/app/app_flavor.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/widgets/client_provider.dart';
import 'package:cplatform_client/cplatform_client.dart';
import 'package:cpub/auto_route.dart';
import 'package:cpub/flutter_bloc.dart';
import 'package:cpub/flutter_localizations.dart';
import 'package:cpub/supabase_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

export 'app_flavor.dart';

/// {@template ChuckleChestApp}
///
/// The main application widget for the ChuckleChest app.
///
/// This widget is responsible for setting up the application theme,
/// routing and localization.
///
/// {@endtemplate}
class ChuckleChestApp extends StatefulWidget {
  /// {@macro ChuckleChestApp}
  const ChuckleChestApp({required this.flavor, super.key});

  /// The flavor of the app.
  final CAppFlavor flavor;

  @override
  State<ChuckleChestApp> createState() => _ChuckleChestAppState();
}

class _ChuckleChestAppState extends State<ChuckleChestApp> {
  late CDatabaseClient databaseClient;
  late CPlatformClient platformClient;
  late CAuthClient authClient;

  late CAuthRepository authRepository;
  late CGemRepository gemRepository;

  late CAppRouter appRouter;

  late Color seedColor;

  @override
  void initState() {
    super.initState();

    final supabaseClient = Supabase.instance.client;

    final gemsTable = CGemsTable(supabaseClient: supabaseClient);

    platformClient = CPlatformClient();
    authClient = CAuthClient(authClient: supabaseClient.auth);
    databaseClient = CDatabaseClient(gemsTable: gemsTable);

    authRepository = CAuthRepository(
      authClient: CAuthClient(authClient: supabaseClient.auth),
    );
    gemRepository = CGemRepository(
      databaseClient: databaseClient,
      platformClient: platformClient,
    );

    appRouter = CAppRouter(authRepository: authRepository);

    seedColor = Colors.primaries[Random(DateTime.now().millisecondsSinceEpoch)
        .nextInt(Colors.primaries.length)];
  }

  @override
  Widget build(BuildContext context) {
    return CMultiClientProvider(
      providers: [
        CClientProvider.value(value: platformClient),
        CClientProvider.value(value: authClient),
        CClientProvider.value(value: databaseClient),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: authRepository),
          RepositoryProvider.value(value: gemRepository),
        ],
        child: MaterialApp.router(
          title: 'ChuckleChest',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
            useMaterial3: true,
          ),
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: PointerDeviceKind.values.toSet(),
          ),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            CCoreL10n.delegate,
            CAppL10n.delegate,
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: CCoreL10n.supportedLocales,
          routerConfig: appRouter.config(
            reevaluateListenable: ReevaluateListenable.stream(
              authRepository.currentUserStream(),
            ),
          ),
          builder: (context, child) => Column(
            children: [
              CStagingBanner(appFlavor: widget.flavor),
              if (child != null) Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
