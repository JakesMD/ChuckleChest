import 'package:cchest_repository/cchest_repository.dart';
import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/cdatabase_client.dart';

/// The repository for interacting with chests.
class CChestRepository {
  /// {@macro CChestRepository}
  const CChestRepository({required this.chestClient});

  /// The client for interacting with the gems API.
  final CChestClient chestClient;

  /// Creates a chest with the given [chestName].
  CJob<CChestCreationException, String> createChest({
    required String chestName,
  }) =>
      chestClient.createChest(chestName: chestName).thenEvaluate(
            onFailure: CChestCreationException.fromRaw,
            onSuccess: (chestID) => chestID,
          );
}
