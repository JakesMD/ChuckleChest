import 'package:chuckle_chest/app/_app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'mock_storage.dart';
import 'test_clients.dart';

extension CWidgetTesterX on WidgetTester {
  /// Pumps the full [ChuckleChestApp] with mock clients and optional deep link.
  ///
  /// Uses real repositories, real blocs, and real routing — only clients
  /// are mocked. Pass [startAt] as a URL path (e.g. `'/signin'`) to set
  /// initial route.
  Future<void> pumpChuckleChestApp({
    CTestClients? clients,
    String? startAt,
  }) async {
    HydratedBloc.storage = buildMockStorage();

    final testClients = clients ?? CTestClients();

    await pumpWidget(
      CAppDependenciesProvider(
        authClient: testClients.authClient,
        chestClient: testClients.chestClient,
        gemClient: testClients.gemClient,
        personClient: testClients.personClient,
        platformClient: testClients.platformClient,
        storageClient: testClients.storageClient,
        builder: (context) => ChuckleChestApp(
          flavor: CAppFlavor.development,
          dependencyContext: context,
          initialDeepLink: startAt,
        ),
      ),
    );

    await pumpAndSettle();
  }
}
