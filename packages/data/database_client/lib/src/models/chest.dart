import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'chest.g.dart';

/// {@template CChest}
///
/// A model for the `chests` table.
///
/// {@endtemplate}
@PgModelHere()
class CRawChest extends PgModel<CChestsTable> {
  /// {@macro CRawChest}
  CRawChest(super.json) : super(builder: builder);

  /// The builder for the model.
  static final builder = PgModelBuilder<CChestsTable, CRawChest>(
    constructor: CRawChest.new,
    columns: [CChestsTable.name, CChestsTable.id],
  );
}
