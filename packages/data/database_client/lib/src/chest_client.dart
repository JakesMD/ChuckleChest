import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
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
  });

  /// The table that represents the `chests` table in the database.
  final CChestsTable chestsTable;

  /// The table that represents the `invitations` table in the database.
  final CInvitationsTable invitationsTable;

  /// The table that represents the `user_roles` table in the database.
  final CUserRolesTable userRolesTable;

  /// Creates a new chest with the given `chestName`.
  BobsJob<CRawChestInsertException, String> createChest({
    required String chestName,
  }) =>
      BobsJob.attempt(
        run: () => chestsTable.insert(
          records: [CChestsTableInsert(name: chestName)],
          columns: {CChestsTable.id},
          modifier: chestsTable.limit(1).single(),
        ),
        onError: CRawChestInsertException.fromError,
      ).then(run: (record) => record.id);

  /// Fetches the invitations for the user with the given `email`.
  BobsJob<CRawUserInvitationsFetchException, List<CInvitationsTableRecord>>
      fetchUserInvitations({required String email}) => BobsJob.attempt(
            run: () => invitationsTable.fetch(
              columns: {
                CInvitationsTable.assignedRole,
                CInvitationsTable.chest({CChestsTable.name, CChestsTable.id}),
              },
              filter: invitationsTable.equal(CInvitationsTable.email(email)),
              modifier: invitationsTable.all(),
            ),
            onError: CRawUserInvitationsFetchException.fromError,
          );

  /// Accepts the invitation to the chest with the given `chestID`.
  BobsJob<CRawInvitationAcceptException, BobsNothing> acceptInvitation({
    required String chestID,
  }) =>
      BobsJob.attempt(
        run: () async {
          await invitationsTable.supabaseClient.rpc(
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
            values: {CChestsTable.name(name)},
            filter: chestsTable.equal(CChestsTable.id(chestID)),
            modifier: chestsTable.none(),
          );
          return bobsNothing;
        },
        onError: CRawChestUpdateException.fromError,
      );

  /// Fetches the invitations for the chest with the given `chestID`.
  BobsJob<CRawChestInvitationsFetchException, List<CInvitationsTableRecord>>
      fetchChestInvitations({required String chestID}) => BobsJob.attempt(
            run: () => invitationsTable.fetch(
              columns: {
                CInvitationsTable.email,
                CInvitationsTable.assignedRole,
                CInvitationsTable.chestID,
              },
              filter:
                  invitationsTable.equal(CInvitationsTable.chestID(chestID)),
              modifier: invitationsTable.all(),
            ),
            onError: CRawChestInvitationsFetchException.fromError,
          );

  /// Fetches all the members of the chest with the given `chestID`.
  BobsJob<CRawChestMembersFetchException, List<CUserRolesTableRecord>>
      fetchChestMembers({required String chestID}) => BobsJob.attempt(
            run: () => userRolesTable.fetch(
              columns: {
                CUserRolesTable.chestID,
                CUserRolesTable.role,
                CUserRolesTable.user({
                  CUsersTable.id,
                  CUsersTable.username,
                }),
              },
              filter: userRolesTable.equal(CUserRolesTable.chestID(chestID)),
              modifier: userRolesTable.all(),
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
            values: {CUserRolesTable.role(role)},
            filter: userRolesTable
                .equal(CUserRolesTable.chestID(chestID))
                .equal(CUserRolesTable.userID(userID)),
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
            records: [
              CInvitationsTableInsert(
                chestID: chestID,
                email: email,
                assignedRole: assignedRole,
              ),
            ],
            modifier: invitationsTable.none(),
          );
          return bobsNothing;
        },
        onError: CRawInvitationCreationException.fromError,
      );
}
