import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cchest_repository/cchest_repository.dart';
import 'package:cdatabase_client/cdatabase_client.dart';

/// The repository for interacting with chests.
class CChestRepository {
  /// {@macro CChestRepository}
  const CChestRepository({required this.chestClient});

  /// The client for interacting with the gems API.
  final CChestClient chestClient;

  /// Creates a chest with the given [chestName].
  BobsJob<CChestCreationException, String> createChest({
    required String chestName,
  }) =>
      chestClient.createChest(chestName: chestName).thenEvaluate(
            onFailure: CChestCreationException.fromRaw,
            onSuccess: (chestID) => chestID,
          );

  /// Fetches the user's invitations.
  BobsJob<CUserInvitationsFetchException, List<CUserInvitation>>
      fetchUserInvitations({required String email}) =>
          chestClient.fetchUserInvitations(email: email).thenEvaluate(
                onFailure: CUserInvitationsFetchException.fromRaw,
                onSuccess: (invitations) =>
                    invitations.map(CUserInvitation.fromRecord).toList(),
              );

  /// Accepts the invitation to the chest with the given [chestID].
  BobsJob<CInvitationAcceptException, BobsNothing> acceptInvitation({
    required String chestID,
  }) =>
      chestClient.acceptInvitation(chestID: chestID).thenEvaluate(
            onFailure: CInvitationAcceptException.fromRaw,
            onSuccess: (s) => s,
          );

  /// Updates the chest with the given [chestID] to have the given [name].
  BobsJob<CChestUpdateException, BobsNothing> updateChest({
    required String chestID,
    required String name,
  }) =>
      chestClient.updateChestName(chestID: chestID, name: name).thenEvaluate(
            onFailure: CChestUpdateException.fromRaw,
            onSuccess: (s) => s,
          );
}
