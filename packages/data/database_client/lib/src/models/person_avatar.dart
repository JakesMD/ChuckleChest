import 'package:cdatabase_client/cdatabase_client.dart';
import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'person_avatar.g.dart';

/// {@template CRawPersonAvatar}
///
/// A model for the `avatars` table.
///
/// {@endtemplate}
@PgModelHere()
class CRawPersonAvatar extends PgModel<CAvatarsTable> {
  /// {@macro CRawPersonAvatar}
  CRawPersonAvatar(super.json) : super(builder: builder);

  /// The builder for the model.
  static final builder = PgModelBuilder<CAvatarsTable, CRawPersonAvatar>(
    constructor: CRawPersonAvatar.new,
    columns: [
      CAvatarsTable.year,
      CAvatarsTable.imageURL,
    ],
  );
}
