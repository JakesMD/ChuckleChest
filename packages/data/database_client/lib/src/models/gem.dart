import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'gem.g.dart';

/// {@template CChest}
///
/// A model for the `gems` table.
///
/// {@endtemplate}
@PgModelHere()
class CRawGem extends PgModel<CGemsTable> {
  /// {@macro CRawGem}
  CRawGem(super.json) : super(builder: builder);

  /// The builder for the model.
  static final builder = PgModelBuilder<CGemsTable, CRawGem>(
    constructor: CRawGem.new,
    columns: [
      CGemsTable.id,
      CGemsTable.chestID,
      CGemsTable.number,
      CGemsTable.occurredAt,
      CGemsTable.lines(CRawLine.builder),
      CGemsTable.shareToken(CRawGemShareToken.builder),
    ],
  );
}
