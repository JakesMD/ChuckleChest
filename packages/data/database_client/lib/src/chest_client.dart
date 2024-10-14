import 'package:bobs_jobs/bobs_jobs.dart';
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
  });

  /// The table that represents the `chests` table in the database.
  final CChestsTable chestsTable;

  /// The table that represents the `invitations` table in the database.
  final CInvitationsTable invitationsTable;

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
}
