import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'person.g.dart';

/// {@template CRawPerson}
///
/// A model for the `people` table.
///
/// {@endtemplate}
@PgModelHere()
class CRawPerson extends PgModel<CPeopleTable> {
  /// {@macro CRawPerson}
  CRawPerson(super.json) : super(builder: builder);

  /// The builder for the model.
  static final builder = PgModelBuilder<CPeopleTable, CRawPerson>(
    constructor: CRawPerson.new,
    columns: [
      CPeopleTable.id,
      CPeopleTable.chestID,
      CPeopleTable.nickname,
      CPeopleTable.dateOfBirth,
      CPeopleTable.avatars(CRawPersonAvatar.builder),
    ],
  );
}
