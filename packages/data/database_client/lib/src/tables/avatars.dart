// coverage:ignore-file

import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'avatars.g.dart';

/// {@template CAvatarsTable}
///
/// Represents the `avatars` table in the Supabase database.
///
/// {@endtemplate}
@SupaTableHere()
class CAvatarsTable extends SupaTable<CAvatarsTableCore, CAvatarsTableRecord> {
  /// {@macro CAvatarsTable}
  const CAvatarsTable({required super.supabaseClient})
      : super(
          CAvatarsTableRecord.new,
          tableName: 'avatars',
          primaryKey: const ['person_id', 'year'],
        );

  /// The unique identifier of the person.
  @SupaColumnHere<BigInt>()
  static const personID =
      SupaColumn<CAvatarsTableCore, BigInt, int>(name: 'person_id');

  /// The year the photo was taken.
  @SupaColumnHere<int>()
  static const year = SupaColumn<CAvatarsTableCore, int, int>(name: 'year');

  /// The URL of the photo of the person at that age.
  @SupaColumnHere<String>()
  static const imageURL =
      SupaColumn<CAvatarsTableCore, String, String>(name: 'image_url');

  /// The ID of the chest the person belongs to.
  @SupaColumnHere<String>()
  static const chestID =
      SupaColumn<CAvatarsTableCore, String, String>(name: 'chest_id');
}
