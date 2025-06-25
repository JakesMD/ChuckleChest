import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'user.g.dart';

/// {@template CChest}
///
/// A model for the `users` table.
///
/// {@endtemplate}
@PgModelHere()
class CRawUser extends PgModel<CUsersTable> {
  /// {@macro CRawUser}
  CRawUser(super.json) : super(builder: builder);

  /// The builder for the model.
  static final builder = PgModelBuilder<CUsersTable, CRawUser>(
    constructor: CRawUser.new,
    columns: [CUsersTable.id, CUsersTable.username],
  );
}
