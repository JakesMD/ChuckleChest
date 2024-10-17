// coverage:ignore-file

import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'users.g.dart';

/// {@template CUsersTable}
///
/// Represents the `user` table in the Supabase database.
///
/// {@endtemplate}
@SupaTableHere()
class CUsersTable extends SupaTable<CUsersTableCore, CUsersTableRecord> {
  /// {@macro CUsersTable}
  const CUsersTable({required super.supabaseClient})
      : super(
          CUsersTableRecord.new,
          tableName: 'users',
          primaryKey: const ['id'],
        );

  /// The ID of the user.
  @SupaColumnHere<String>()
  static const id = SupaColumn<CUsersTableCore, String, String>(name: 'id');

  /// The username of the user.
  @SupaColumnHere<String?>()
  static const username =
      SupaColumn<CUsersTableCore, String?, String?>(name: 'username');
}
