// coverage:ignore-file

import 'dart:async';

import 'package:cpub/supabase.dart';
import 'package:cpub_dev/mocktail.dart';
import 'package:flutter/foundation.dart';

const _bDebugDelay = Duration(milliseconds: 500);

/// {@template CSupabaseClient}
///
/// Client for interacting with Supabase.
///
/// Provides methods for common database operations like inserting, updating,
/// counting rows, and streaming query results.
///
/// The actual [SupabaseClient] is passed in, allowing this client to be
/// initialized with different backend Supabase clients.
///
/// {@endtemplate}
class CSupabaseClient {
  /// {@macro CSupabaseClient}
  CSupabaseClient({required this.supabaseClient});

  /// Client for interacting with Supabase.
  final SupabaseClient supabaseClient;

  /// The [GoTrueClient] used to interact with Supabase auth.
  GoTrueClient get authClient => supabaseClient.auth;

  /// Counts the number of rows in [table] with columns matching [columns].
  ///
  /// Uses the Supabase client to run a query that returns the exact count.
  Future<int> count({required String table, required String columns}) async {
    if (kDebugMode) await Future.delayed(_bDebugDelay);
    final result = await supabaseClient
        .from(table)
        .select(columns)
        .count(CountOption.exact);

    return result.count;
  }

  /// Inserts a row into the specified [table] and returns the inserted value
  /// for the specified [primaryKey] column.
  ///
  /// The [values] map contains the column names and values to insert.
  ///
  /// Uses the Supabase client to insert the row and select the value of the
  /// primary key column in the inserted row.
  Future<List<Map<String, dynamic>>> insert({
    required String table,
    required String primaryKey,
    required Object values,
  }) async {
    if (kDebugMode) await Future.delayed(_bDebugDelay);
    return await supabaseClient.from(table).insert(values).select(primaryKey);
  }

  /// Updates a row in the specified [table] where [eqColumn] equals [eqValue].
  ///
  /// The [values] map contains the column names and new values to update.
  Future<void> update({
    required String table,
    required Map<String, dynamic> values,
    required String eqColumn,
    required Object eqValue,
  }) async {
    if (kDebugMode) await Future.delayed(_bDebugDelay);
    return await supabaseClient
        .from(table)
        .update(values)
        .eq(eqColumn, eqValue);
  }

  /// Streams rows from the specified table where the equality, limit,
  /// order by, and ascending clauses are applied.
  ///
  /// The [table] parameter specifies the table name to query.
  ///
  /// The [primaryKey] parameter specifies the primary key columns to monitor
  /// for changes.
  ///
  /// The [eqColumn] and [eqValue] parameters add an equality filter.
  ///
  /// The [limit] parameter limits the number of rows.
  ///
  /// The [orderColumn] and [ascending] parameters sort the results.
  Stream<List<Map<String, dynamic>>> stream({
    required String table,
    required List<String> primaryKey,
    required int limit,
    required String eqColumn,
    required Object eqValue,
    required String orderColumn,
    bool ascending = false,
  }) {
    return supabaseClient
        .from(table)
        .stream(primaryKey: primaryKey)
        .eq(eqColumn, eqValue)
        .limit(limit)
        .order(orderColumn, ascending: ascending);
  }

  /// Fetches rows from the specified table where the equality, limit,
  /// order by, and ascending clauses are applied.
  ///
  /// The [table] parameter specifies the table name to query.
  ///
  /// The [eqColumn] and [eqValue] parameters add an equality filter.
  ///
  /// The [limit] parameter limits the number of rows.
  ///
  /// The [orderColumn] and [ascending] parameters sort the results.
  Future<List<Map<String, dynamic>>> fetch({
    required String table,
    required int limit,
    required String eqColumn,
    required Object eqValue,
    required String orderColumn,
    bool ascending = false,
    String columns = '*',
  }) async {
    if (kDebugMode) await Future.delayed(_bDebugDelay);
    return await supabaseClient
        .from(table)
        .select(columns)
        .eq(eqColumn, eqValue)
        .limit(limit)
        .order(orderColumn, ascending: ascending);
  }

  /// Fetches a single row from the specified table where the equality clause is
  /// applied.
  ///
  /// The [table] parameter specifies the table name to query.
  ///
  /// The [eqColumn] and [eqValue] parameters add an equality filter.
  Future<Map<String, dynamic>> fetchSingle({
    required String table,
    required String eqColumn,
    required Object eqValue,
    String columns = '*',
  }) async {
    if (kDebugMode) await Future.delayed(_bDebugDelay);
    return await supabaseClient
        .from(table)
        .select(columns)
        .eq(eqColumn, eqValue)
        .limit(1)
        .single();
  }

  /// Fetches rows from the specified table where the contains, limit,
  /// order by, and ascending clauses are applied.
  ///
  /// The [table] parameter specifies the table name to query.
  ///
  /// The [containsColumn] and [containsValue] parameters add an contains
  /// filter.
  ///
  /// The [limit] parameter limits the number of rows.
  ///
  /// The [orderColumn] and [ascending] parameters sort the results.
  Future<List<Map<String, dynamic>>> fetchThatContain({
    required String table,
    required int limit,
    required String containsColumn,
    required Object containsValue,
    required String orderColumn,
    bool ascending = false,
    String columns = '*',
  }) async {
    if (kDebugMode) await Future.delayed(_bDebugDelay);
    return await supabaseClient
        .from(table)
        .select(columns)
        .contains(containsColumn, [containsValue])
        .limit(limit)
        .order(orderColumn, ascending: ascending);
  }

  /// Fetches rows from the specified table where the equality, limit,
  /// order by, and ascending clauses are applied.
  ///
  /// The [table] parameter specifies the table name to query.
  ///
  /// The [eqColumn] and [eqValues] parameters add an equality filter.
  ///
  /// The [limit] parameter limits the number of rows.
  ///
  /// The [orderColumn] and [ascending] parameters sort the results.
  Future<List<Map<String, dynamic>>> fetchIn({
    required String table,
    required int limit,
    required String eqColumn,
    required List<Object> eqValues,
    required String orderColumn,
    bool ascending = false,
    String columns = '*',
  }) async {
    if (kDebugMode) await Future.delayed(_bDebugDelay);
    return await supabaseClient
        .from(table)
        .select(columns)
        .inFilter(eqColumn, eqValues)
        .limit(limit)
        .order(orderColumn, ascending: ascending);
  }

  /// Deletes rows from the specified [table] where columns
  /// match the given [match] values.
  Future<void> delete({
    required String table,
    required Map<String, Object> match,
  }) async {
    if (kDebugMode) await Future.delayed(_bDebugDelay);
    return await supabaseClient.from(table).delete().match(match);
  }

  /// Calls the specified [functionName] with the given [params].
  Future<T> call<T>({
    required String functionName,
    required Map<String, dynamic> params,
  }) async {
    if (kDebugMode) await Future.delayed(_bDebugDelay);
    return await supabaseClient.rpc<T>(functionName, params: params);
  }
}

/// Mocks the [CSupabaseClient] class.
class MockCSupabaseClient extends Mock implements CSupabaseClient {
  /// Mocks the [CSupabaseClient.fetchSingle] method.
  Future<Map<String, dynamic>> mockFetchSingle() => fetchSingle(
        table: any(named: 'table'),
        eqColumn: any(named: 'eqColumn'),
        eqValue: any(named: 'eqValue'),
        columns: any(named: 'columns'),
      );

  /// Mocks the [CSupabaseClient.fetch] method.
  Future<List<Map<String, dynamic>>> mockFetch() => fetch(
        table: any(named: 'table'),
        limit: any(named: 'limit'),
        eqColumn: any(named: 'eqColumn'),
        eqValue: any(named: 'eqValue'),
        orderColumn: any(named: 'orderColumn'),
        ascending: any(named: 'ascending'),
        columns: any(named: 'columns'),
      );

  /// Mocks the [CSupabaseClient.fetchIn] method.
  Future<List<Map<String, dynamic>>> mockFetchIn() => fetchIn(
        table: any(named: 'table'),
        limit: any(named: 'limit'),
        eqColumn: any(named: 'eqColumn'),
        eqValues: any(named: 'eqValues'),
        orderColumn: any(named: 'orderColumn'),
        ascending: any(named: 'ascending'),
        columns: any(named: 'columns'),
      );

  /// Mocks the [CSupabaseClient.insert] method.
  Future<List<Map<String, dynamic>>> mockInsert() => insert(
        table: any(named: 'table'),
        primaryKey: any(named: 'primaryKey'),
        values: any(named: 'values'),
      );

  /// Mocks the [CSupabaseClient.update] method.
  Future<void> mockUpdate() => update(
        table: any(named: 'table'),
        values: any(named: 'values'),
        eqColumn: any(named: 'eqColumn'),
        eqValue: any(named: 'eqValue'),
      );

  /// Mocks the [CSupabaseClient.stream] method.
  Stream<List<Map<String, dynamic>>> mockStream() => stream(
        table: any(named: 'table'),
        primaryKey: any(named: 'primaryKey'),
        limit: any(named: 'limit'),
        eqColumn: any(named: 'eqColumn'),
        eqValue: any(named: 'eqValue'),
        ascending: any(named: 'ascending'),
        orderColumn: any(named: 'orderColumn'),
      );

  /// Mocks the [CSupabaseClient.delete] method.
  Future<void> mockDelete() => delete(
        table: any(named: 'table'),
        match: any(named: 'match'),
      );

  /// Mocks the [CSupabaseClient.fetchThatContain] method.
  Future<List<Map<String, dynamic>>> mockFetchThatContain() => fetchThatContain(
        table: any(named: 'table'),
        limit: any(named: 'limit'),
        containsColumn: any(named: 'containsColumn'),
        containsValue: any(named: 'containsValue'),
        orderColumn: any(named: 'orderColumn'),
        ascending: any(named: 'ascending'),
        columns: any(named: 'columns'),
      );

  /// Mocks the [CSupabaseClient.call] method.
  Future<T> mockCall<T>() => call<T>(
        functionName: any(named: 'functionName'),
        params: any(named: 'params'),
      );
}
