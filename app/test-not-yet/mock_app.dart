import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/localization/l10n.dart';
import 'package:chuckle_chest/shared/widgets/client_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockCApp extends StatelessWidget {
  const MockCApp({
    required this.child,
    this.clients = const [],
    this.repositories = const [],
    this.blocProviders = const [],
    super.key,
  });

  final Widget child;

  final List<Mock> clients;

  final List<Mock> repositories;

  final List<BlocProvider> blocProviders;

  Widget buildClients({
    required Widget child,
  }) {
    if (clients.isEmpty) return child;
    return CMultiClientProvider(
      providers: [
        for (final client in clients)
          CClientProvider(create: (context) => client),
      ],
      child: child,
    );
  }

  Widget buildRepositories({
    required Widget child,
  }) {
    if (repositories.isEmpty) return child;
    return MultiRepositoryProvider(
      providers: [
        for (final repo in repositories)
          RepositoryProvider(create: (context) => repo),
      ],
      child: child,
    );
  }

  Widget buildBlocProviders({
    required Widget child,
  }) {
    if (blocProviders.isEmpty) return child;
    return MultiBlocProvider(
      providers: blocProviders,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: const [
        CAppL10n.delegate,
        CCoreL10n.delegate,
      ],
      home: buildClients(
        child: buildRepositories(
          child: buildBlocProviders(
            child: child,
          ),
        ),
      ),
    );
  }
}
