import 'package:ccore/ccore.dart';
import 'package:cgem_client/cgem_client.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/app/app_flavor.dart';
import 'package:chuckle_chest/app/router.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/widgets/_widgets.dart';
import 'package:chuckle_chest/shared/widgets/client_provider.dart';
import 'package:cplatform_client/cplatform_client.dart';
import 'package:cpub/flutter_bloc.dart';
import 'package:cpub/flutter_localizations.dart';
import 'package:cpub/supabase_flutter.dart';
import 'package:csupabase_client/csupabase_client.dart';
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
class ChuckleChestApp extends StatelessWidget {
  /// {@macro ChuckleChestApp}
  ChuckleChestApp({required this.flavor, super.key});

  /// The flavor of the app.
  final CAppFlavor flavor;

  final _router = CAppRouter();

  @override
  Widget build(BuildContext context) {
    return CMultiClientProvider(
      providers: [
        CClientProvider(
          create: (context) => CSupabaseClient(
            supabaseClient: Supabase.instance.client,
          ),
        ),
        CClientProvider(create: (context) => CPlatformClient()),
        CClientProvider(
          create: (context) => CGemClient(
            supabaseClient: context.read<CSupabaseClient>(),
          ),
        ),
      ],
      child: RepositoryProvider(
        create: (context) => CGemRepository(
          platformClient: context.read<CPlatformClient>(),
          gemClient: context.read<CGemClient>(),
        ),
        child: MaterialApp.router(
          title: 'ChuckleChest',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
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
          routerConfig: _router.config(),
          builder: (context, child) => Column(
            children: [
              CStagingBanner(appFlavor: flavor),
              if (child != null) Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
