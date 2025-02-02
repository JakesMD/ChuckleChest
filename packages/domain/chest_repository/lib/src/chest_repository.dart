import 'package:bobs_jobs/bobs_jobs.dart';
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
  BobsJob<CChestCreationException, String> createChest({
    required String chestName,
  }) =>
      chestClient.createChest(chestName: chestName).thenConvert(
            onFailure: CChestCreationException.fromRaw,
            onSuccess: (chestID) => chestID,
          );

  /// Fetches the user's invitations.
  BobsJob<CUserInvitationsFetchException, List<CUserInvitation>>
      fetchUserInvitations({required String email}) =>
          chestClient.fetchUserInvitations(email: email).thenConvert(
                onFailure: CUserInvitationsFetchException.fromRaw,
                onSuccess: (invitations) =>
                    invitations.map(CUserInvitation.fromRecord).toList(),
              );

  /// Accepts the invitation to the chest with the given [chestID].
  BobsJob<CInvitationAcceptException, BobsNothing> acceptInvitation({
    required String chestID,
  }) =>
      chestClient.acceptInvitation(chestID: chestID).thenConvert(
            onFailure: CInvitationAcceptException.fromRaw,
            onSuccess: (s) => s,
          );

  /// Updates the chest with the given [chestID] to have the given [name].
  BobsJob<CChestUpdateException, BobsNothing> updateChest({
    required String chestID,
    required String name,
  }) =>
      chestClient.updateChestName(chestID: chestID, name: name).thenConvert(
            onFailure: CChestUpdateException.fromRaw,
            onSuccess: (s) => s,
          );

  /// Fetches the invitations for the chest with the given [chestID].
  BobsJob<CChestInvitationsFetchException, List<CChestInvitation>>
      fetchChestInvitations({required String chestID}) =>
          chestClient.fetchChestInvitations(chestID: chestID).thenConvert(
                onFailure: CChestInvitationsFetchException.fromRaw,
                onSuccess: (invitations) =>
                    invitations.map(CChestInvitation.fromRecord).toList(),
              );

  /// Fetches the members for the chest with the given [chestID].
  BobsJob<CMembersFetchException, List<CMember>> fetchMembers({
    required String chestID,
  }) =>
      chestClient.fetchChestMembers(chestID: chestID).thenConvert(
            onFailure: CMembersFetchException.fromRaw,
            onSuccess: (members) => members.map(CMember.fromRecord).toList(),
          );

  /// Updates the role of the [member] to the given [role].
  BobsJob<CMemberRoleUpdateException, BobsNothing> updateMemberRole({
    required CMember member,
    required CUserRole role,
  }) =>
      chestClient
          .updateMemberRole(
            chestID: member.chestID,
            userID: member.userID,
            role: role,
          )
          .thenConvert(
            onFailure: CMemberRoleUpdateException.fromRaw,
            onSuccess: (s) => s,
          );

  /// Creates an invitation for the chest.
  BobsJob<CInvitationCreationException, BobsNothing> createInvitation({
    required CChestInvitation invitation,
  }) =>
      chestClient
          .createInvitation(
            email: invitation.email,
            chestID: invitation.chestID,
            assignedRole: invitation.assignedRole,
          )
          .thenConvert(
            onFailure: CInvitationCreationException.fromRaw,
            onSuccess: (s) => s,
          );
}
