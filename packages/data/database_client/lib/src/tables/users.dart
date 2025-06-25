// coverage:ignore-file

import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'users.g.dart';

/// {@template CUsersTable}
///
/// Represents the `user` table in the Supabase database.
///
/// {@endtemplate}
@PgTableHere()
class CUsersTable extends SupabaseTable<CUsersTable> {
  /// {@macro CUsersTable}
  CUsersTable(super.client) : super(tableName: tableName, primaryKey: [id]);

  /// The name of the table in the Supabase database.
  static const tableName = PgTableName<CUsersTable>('users');

  /// The ID of the user.
  static final id = PgStringColumn<CUsersTable>('id');

  /// The username of the user.
  static final username = PgMaybeStringColumn<CUsersTable>('username');
}
