// coverage:ignore-file

import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'avatar_urls.g.dart';

/// {@template CAvatarURLsTable}
///
/// Represents the `person_avatar_urls` table in the Supabase database.
///
/// {@endtemplate}
@SupaTableHere()
class CAvatarURLsTable
    extends SupaTable<CAvatarURLsTableCore, CAvatarURLsTableRecord> {
  /// {@macro CAvatarURLsTable}
  const CAvatarURLsTable({required super.supabaseClient})
      : super(
          CAvatarURLsTableRecord.new,
          tableName: 'person_avatar_urls',
          primaryKey: 'person_id_age',
        );

  /// The unique identifier of the person.
  @SupaColumnHere<BigInt>()
  static const personID =
      SupaColumn<CAvatarURLsTableCore, BigInt, int>(name: 'personID');

  /// The URL of the photo of the person at that age.
  @SupaColumnHere<String>()
  static const url =
      SupaColumn<CAvatarURLsTableCore, String, String>(name: 'url');

  /// The age of the person at the time the photo was taken.
  @SupaColumnHere<int>()
  static const age = SupaColumn<CAvatarURLsTableCore, int, int>(name: 'age');
}
