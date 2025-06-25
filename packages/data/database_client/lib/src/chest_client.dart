import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:supabase/supabase.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

/// {@template CChestClient}
///
/// The client to interact with the chest API.
///
/// {@endtemplate}
class CChestClient {
  /// {@macro CChestClient}
  const CChestClient({
    required this.chestsTable,
    required this.invitationsTable,
    required this.userRolesTable,
    required this.supabaseClient,
  });

  /// The table that represents the `chests` table in the database.
  final CChestsTable chestsTable;

  /// The table that represents the `invitations` table in the database.
  final CInvitationsTable invitationsTable;

  /// The table that represents the `user_roles` table in the database.
  final CUserRolesTable userRolesTable;

  /// The Supabase client.
  final SupabaseClient supabaseClient;

  /// Creates a new chest with the given `chestName`.
  BobsJob<CRawChestInsertException, String> createChest({
    required String chestName,
  }) =>
      BobsJob.attempt(
        run: () => chestsTable.insertAndFetchValue(
          inserts: [CChestsTableInsert(name: chestName)],
          column: CChestsTable.id,
        ),
        onError: CRawChestInsertException.fromError,
      );

  /// Fetches the invitations for the user with the given `email`.
  BobsJob<CRawInvitationsFetchException, List<CRawInvitation>>
      fetchUserInvitations({required String email}) => BobsJob.attempt(
            run: () => invitationsTable.fetchModels(
              modelBuilder: CRawInvitation.builder,
              filter: CInvitationsTable.email.equals(email),
            ),
            onError: CRawInvitationsFetchException.fromError,
          );

  /// Accepts the invitation to the chest with the given `chestID`.
  BobsJob<CRawInvitationAcceptException, BobsNothing> acceptInvitation({
    required String chestID,
  }) =>
      BobsJob.attempt(
        run: () async {
          await supabaseClient.rpc(
            'accept_invitation',
            params: {'chest_id_param': chestID},
          );
          return bobsNothing;
        },
        onError: CRawInvitationAcceptException.fromError,
      );

  /// Updates the name of the chest with the given `chestID` to the given
  /// `name`.
  BobsJob<CRawChestUpdateException, BobsNothing> updateChestName({
    required String chestID,
    required String name,
  }) =>
      BobsJob.attempt(
        run: () async {
          await chestsTable.update(
            values: [CChestsTable.name(name)],
            filter: CChestsTable.id.equals(chestID),
          );
          return bobsNothing;
        },
        onError: CRawChestUpdateException.fromError,
      );

  /// Fetches the invitations for the chest with the given `chestID`.
  BobsJob<CRawChestInvitationsFetchException, List<CRawInvitation>>
      fetchChestInvitations({required String chestID}) => BobsJob.attempt(
            run: () => invitationsTable.fetchModels(
              modelBuilder: CRawInvitation.builder,
              filter: CInvitationsTable.chestID.equals(chestID),
            ),
            onError: CRawChestInvitationsFetchException.fromError,
          );

  /// Fetches all the members of the chest with the given `chestID`.
  BobsJob<CRawChestMembersFetchException, List<CRawMember>> fetchChestMembers({
    required String chestID,
  }) =>
      BobsJob.attempt(
        run: () => userRolesTable.fetchModels(
          modelBuilder: CRawMember.builder,
          filter: CUserRolesTable.chestID.equals(chestID),
        ),
        onError: CRawChestMembersFetchException.fromError,
      );

  /// Updates the role of the member with the given `userID` in the chest with
  /// the given `chestID` to the given `role`.
  BobsJob<CRawMemberRoleUpdateException, BobsNothing> updateMemberRole({
    required String chestID,
    required String userID,
    required CUserRole role,
  }) =>
      BobsJob.attempt(
        run: () async {
          await userRolesTable.update(
            values: [CUserRolesTable.role(role)],
            filter: userRolesTable
                .where(CUserRolesTable.chestID.equals(chestID))
                .and(CUserRolesTable.userID.equals(userID)),
            modifier: userRolesTable.none(),
          );
          return bobsNothing;
        },
        onError: CRawMemberRoleUpdateException.fromError,
      );

  /// Creates an invitation for the chest with the given `chestID` to the user
  /// with the given `email` and assigns the given `assignedRole`.
  BobsJob<CRawInvitationCreationException, BobsNothing> createInvitation({
    required String chestID,
    required String email,
    required CUserRole assignedRole,
  }) =>
      BobsJob.attempt(
        run: () async {
          await invitationsTable.insert(
            inserts: [
              CInvitationsTableInsert(
                chestID: chestID,
                email: email,
                assignedRole: assignedRole,
              ),
            ],
          );
          return bobsNothing;
        },
        onError: CRawInvitationCreationException.fromError,
      );
}
