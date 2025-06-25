import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'invitation.g.dart';

/// {@template CRawInvitation}
///
/// A model for the `invitations` table.
///
/// {@endtemplate}
@PgModelHere()
class CRawInvitation extends PgModel<CInvitationsTable> {
  /// {@macro CRawInvitation}
  CRawInvitation(super.json) : super(builder: builder);

  /// The builder for the model.
  static final builder = PgModelBuilder<CInvitationsTable, CRawInvitation>(
    constructor: CRawInvitation.new,
    columns: [
      CInvitationsTable.email,
      CInvitationsTable.assignedRole,
      CInvitationsTable.chest(CRawChest.builder),
    ],
  );
}
