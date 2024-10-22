// coverage:ignore-file

import 'package:typesafe_supabase/typesafe_supabase.dart';

part 'gem_share_tokens.g.dart';

/// {@template CGemShareTokensTable}
///
/// Represents the `gem_share_tokens` table in the Supabase database.
///
/// {@endtemplate}
@SupaTableHere()
class CGemShareTokensTable
    extends SupaTable<CGemShareTokensTableCore, CGemShareTokensTableRecord> {
  /// {@macro CGemShareTokensTable}
  const CGemShareTokensTable({required super.supabaseClient})
      : super(
          CGemShareTokensTableRecord.new,
          tableName: 'gem_share_tokens',
          primaryKey: const ['gem_id'],
        );

  /// The ID of the chest the gem belongs to.
  @SupaColumnHere<String>()
  static const chestID =
      SupaColumn<CGemShareTokensTableCore, String, String>(name: 'chest_id');

  /// The ID of the gem.
  @SupaColumnHere<String>()
  static const gemID =
      SupaColumn<CGemShareTokensTableCore, String, String>(name: 'gem_id');

  /// The token for sharing the gem.
  @SupaColumnHere<String>(hasDefault: true)
  static const token =
      SupaColumn<CGemShareTokensTableCore, String, String>(name: 'token');
}
