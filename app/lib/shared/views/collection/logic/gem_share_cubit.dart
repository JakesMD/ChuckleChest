import 'package:bloc/bloc.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CGemShareState}
///
/// The state for the [CGemShareCubit].
///
/// {@endtemplate}
class CGemShareState
    extends CRequestCubitState<CGemShareException, CGemShareMethod> {
  /// {@macro CGemShareState}
  ///
  /// The initial state.
  CGemShareState.initial() : super.initial();

  /// {@macro CGemShareState}
  ///
  /// The in progress state.
  CGemShareState.inProgress() : super.inProgress();

  /// {@macro CGemShareState}
  ///
  /// The completed state.
  CGemShareState.completed({required super.outcome}) : super.completed();

  /// The method used to share the gem.
  CGemShareMethod get shareMethod => success;
}

/// {@template CGemShareCubit}
///
/// The cubit that handles sharing gems.
///
/// {@endtemplate}
class CGemShareCubit extends Cubit<CGemShareState> {
  /// {@macro CGemShareCubit}
  CGemShareCubit({required this.gemRepository})
      : super(CGemShareState.initial());

  /// The repository this cubit uses to share gems.
  final CGemRepository gemRepository;

  /// Shares the gem with the given [shareToken].
  Future<void> shareGem({
    required String shareToken,
    required String Function(String) message,
    required String subject,
    required Rect sharePositionOrigin,
  }) async {
    emit(CGemShareState.inProgress());

    final result = await gemRepository
        .shareGem(
          shareToken: shareToken,
          subject: subject,
          message: message,
          sharePositionOrigin: sharePositionOrigin,
        )
        .run();

    emit(CGemShareState.completed(outcome: result));
  }
}
