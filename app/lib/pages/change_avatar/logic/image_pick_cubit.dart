import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:ccore/ccore.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:cplatform_repository/cplatform_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CImagePickState}
///
/// The state for the [CImagePickCubit].
///
/// {@endtemplate}
class CImagePickState
    extends CRequestCubitState<CImagePickException, BobsMaybe<Uint8List>> {
  /// {@macro CImagePickState}
  ///
  /// The initial state.
  CImagePickState.initial() : super.initial();

  /// {@macro CImagePickState}
  ///
  /// The in progress state.
  CImagePickState.inProgress() : super.inProgress();

  /// {@macro CImagePickState}
  ///
  /// The completed state.
  CImagePickState.completed({required super.outcome}) : super.completed();

  /// The image that was picked.
  BobsMaybe<Uint8List> get image => success;
}

/// {@template CImagePickCubit}
///
/// The cubit that handles picking an image.
///
/// {@endtemplate}
class CImagePickCubit extends Cubit<CImagePickState> {
  /// {@macro CImagePickCubit}
  CImagePickCubit({required this.platformRepository})
      : super(CImagePickState.initial());

  /// The repository this cubit uses to pick images.
  final CPlatformRepository platformRepository;

  /// Logs the current user out.
  Future<void> pickImage({
    required CImagePickSource source,
    int? width,
    int? height,
  }) async {
    if (state.inProgress) return;
    emit(CImagePickState.inProgress());

    final result = await platformRepository
        .pickImage(source: source, width: width, height: height)
        .run();

    emit(CImagePickState.completed(outcome: result));
  }
}
