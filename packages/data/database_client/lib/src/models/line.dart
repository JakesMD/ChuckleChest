import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'line.g.dart';

/// {@template CRawLine}
///
/// A model for the `lines` table.
///
/// {@endtemplate}
@PgModelHere()
class CRawLine extends PgModel<CLinesTable> {
  /// {@macro CRawLine}
  CRawLine(super.json) : super(builder: builder);

  /// The builder for the model.
  static final builder = PgModelBuilder<CLinesTable, CRawLine>(
    constructor: CRawLine.new,
    columns: [
      CLinesTable.id,
      CLinesTable.text,
      CLinesTable.personID,
      CLinesTable.gemID,
      CLinesTable.chestID,
    ],
  );
}
