import 'package:ccore/ccore.dart';
import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'member.g.dart';

/// {@template CRawMember}
///
/// A model for the `user_roles` table.
///
/// {@endtemplate}
@PgModelHere()
class CRawMember extends PgModel<CUserRolesTable> {
  /// {@macro CRawMember}
  CRawMember(super.json) : super(builder: builder);

  /// The builder for the model.
  static final builder = PgModelBuilder<CUserRolesTable, CRawMember>(
    constructor: CRawMember.new,
    columns: [
      CUserRolesTable.chestID,
      CUserRolesTable.role,
      CUserRolesTable.user(CRawUser.builder),
    ],
  );
}
