import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'gem_share_token.g.dart';

/// {@template CRawGemShareToken}
///
/// A model for the `gem_share_tokens` table.
///
/// {@endtemplate}
@PgModelHere()
class CRawGemShareToken extends PgModel<CGemShareTokensTable> {
  /// {@macro CRawGemShareToken}
  CRawGemShareToken(super.json) : super(builder: builder);

  /// The builder for the model.
  static final builder =
      PgModelBuilder<CGemShareTokensTable, CRawGemShareToken>(
    constructor: CRawGemShareToken.new,
    columns: [CGemShareTokensTable.token],
  );
}
