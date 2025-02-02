import 'package:bloc/bloc.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CGemFetchFromShareTokenState}
///
/// The state for the [CGemFetchFromShareTokenCubit].
///
/// {@endtemplate}
class CGemFetchFromShareTokenState
    extends CRequestCubitState<CGemFetchFromShareTokenException, CSharedGem> {
  /// {@macro CGemFetchFromShareTokenState}
  ///
  /// The initial state.
  CGemFetchFromShareTokenState.initial()
      : shareToken = '',
        super.initial();

  /// {@macro CGemFetchFromShareTokenState}
  ///
  /// The in progress state.
  CGemFetchFromShareTokenState.inProgress({required this.shareToken})
      : super.inProgress();

  /// {@macro CGemFetchFromShareTokenState}
  ///
  /// The completed state.
  CGemFetchFromShareTokenState.completed({
    required super.outcome,
    required this.shareToken,
  }) : super.completed();

  /// The gem that was fetched.
  CGem get gem => success;

  /// The share token associated with the gem.
  final String shareToken;

  @override
  List<Object?> get props => super.props..add(shareToken);
}

/// {@template CGemFetchFromShareTokenCubit}
///
/// The cubit that handles fetching shared gems.
///
/// {@endtemplate}
class CGemFetchFromShareTokenCubit extends Cubit<CGemFetchFromShareTokenState> {
  /// {@macro CGemFetchFromShareTokenCubit}
  CGemFetchFromShareTokenCubit({required this.gemRepository})
      : super(CGemFetchFromShareTokenState.initial());

  /// The repository this cubit uses to fetch shared gems.
  final CGemRepository gemRepository;

  /// Fetches the gem associated with the given [shareToken].
  Future<void> fetchGem({required String shareToken}) async {
    emit(CGemFetchFromShareTokenState.inProgress(shareToken: shareToken));

    final result = await gemRepository
        .fetchGemFromShareToken(shareToken: shareToken)
        .run();

    emit(
      CGemFetchFromShareTokenState.completed(
        outcome: result,
        shareToken: shareToken,
      ),
    );
  }
}
