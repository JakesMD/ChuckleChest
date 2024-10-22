import 'package:bloc/bloc.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CGemShareTokenCreationState}
///
/// The state for the [CGemShareTokenCreationCubit].
///
/// {@endtemplate}
class CGemShareTokenCreationState
    extends CRequestCubitState<CGemShareTokenCreationException, String> {
  /// {@macro CGemShareTokenCreationState}
  ///
  /// The initial state.
  CGemShareTokenCreationState.initial()
      : gemID = '',
        super.initial();

  /// {@macro CGemShareTokenCreationState}
  ///
  /// The in progress state.
  CGemShareTokenCreationState.inProgress({required this.gemID})
      : super.inProgress();

  /// {@macro CGemShareTokenCreationState}
  ///
  /// The completed state.
  CGemShareTokenCreationState.completed({
    required this.gemID,
    required super.outcome,
  }) : super.completed();

  /// The ID of the gem the share token was created for.
  final String gemID;

  /// The share token created.
  String get shareToken => success;
}

/// {@template CGemShareTokenCreationCubit}
///
/// The cubit that handles sharing gems.
///
/// {@endtemplate}
class CGemShareTokenCreationCubit extends Cubit<CGemShareTokenCreationState> {
  /// {@macro CGemShareTokenCreationCubit}
  CGemShareTokenCreationCubit({
    required this.gemRepository,
    required this.chestID,
  }) : super(CGemShareTokenCreationState.initial());

  /// The repository this cubit uses to create gem share tokens.
  final CGemRepository gemRepository;

  /// The ID of the chest this cubit is creating share tokens for.
  final String chestID;

  /// Creates a share token for the gem with the given [gemID].
  Future<void> createShareToken({required String gemID}) async {
    emit(CGemShareTokenCreationState.inProgress(gemID: gemID));

    final result = await gemRepository
        .createGemShareToken(chestID: chestID, gemID: gemID)
        .run(isDebugMode: kDebugMode);

    emit(CGemShareTokenCreationState.completed(gemID: gemID, outcome: result));
  }
}
