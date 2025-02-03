import 'package:bloc/bloc.dart';
import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:chuckle_chest/shared/_shared.dart';
import 'package:cperson_repository/cperson_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template CDemoState}
///
/// The state for the [CDemoCubit].
///
/// {@endtemplate}
class CDemoState extends CRequestCubitState<BobsNothing, CSharedGem> {
  /// The initial state.
  ///
  /// {@macro CDemoState}
  CDemoState.initial()
      : gemID = '',
        super.initial();

  /// The in progress state.
  ///
  /// {@macro CDemoState}
  CDemoState.inProgress({required this.gemID}) : super.inProgress();

  /// The completed state.
  ///
  /// {@macro CDemoState}
  CDemoState.completed({required CSharedGem gem})
      : gemID = gem.id,
        super.completed(outcome: BobsSuccess(gem));

  /// THe unique identifier of the gem to be fetched.
  final String gemID;

  /// The gem that was fetched.
  CSharedGem get gem => success;

  @override
  List<Object?> get props => super.props..add(gemID);
}

/// {@template CDemoCubit}
///
/// The cubit mimics being a cubit that fetches shared gems.
///
/// {@endtemplate}
class CDemoCubit extends Cubit<CDemoState> {
  /// {@macro CDemoCubit}
  CDemoCubit() : super(CDemoState.initial());

  final _people = [
    CPerson(
      id: BigInt.zero,
      nickname: 'Amy',
      dateOfBirth: DateTime(2022),
      avatarURLs: [
        const CAvatarURL(
          url:
              'https://mgopsyysiuhacmfpxpdd.supabase.co/storage/v1/object/public/avatars/demo/small%20girl.jpg',
          year: 2024,
        ),
      ],
      chestID: 'demo',
    ),
    CPerson(
      id: BigInt.one,
      nickname: 'Mum',
      dateOfBirth: DateTime(1995),
      avatarURLs: [
        const CAvatarURL(
          url:
              'https://mgopsyysiuhacmfpxpdd.supabase.co/storage/v1/object/public/avatars/demo/mum.jpg',
          year: 2024,
        ),
      ],
      chestID: 'demo',
    ),
  ];

  /// The demo gems.
  List<CSharedGem> get gems => [
        CSharedGem(
          id: 'demo1',
          number: 156,
          occurredAt: DateTime(2024, 8, 10),
          lines: [
            CLine(
              id: BigInt.zero,
              text: "What's the baby doing?",
              personID: BigInt.zero,
              gemID: 'demo1',
              chestID: 'demo',
            ),
            CLine(
              id: BigInt.one,
              text: "I think he's trying to suck his thumb like you do.",
              personID: BigInt.one,
              gemID: 'demo1',
              chestID: 'demo',
            ),
            CLine(
              id: BigInt.two,
              text:
                  '''Yes, I suck my thumb, dribble on my tiger pillow, and pick my nose.''',
              personID: BigInt.zero,
              gemID: 'demo1',
              chestID: 'demo',
            ),
          ],
          chestID: 'demo',
          shareToken: null,
          people: _people,
        ),
        CSharedGem(
          id: 'demo2',
          number: 174,
          occurredAt: DateTime(2024, 12, 22),
          lines: [
            CLine(
              id: BigInt.zero,
              text: 'Amy announcing the next song at the school nativity:',
              personID: null,
              gemID: 'demo2',
              chestID: 'demo',
            ),
            CLine(
              id: BigInt.one,
              text: 'A whale in a manger!',
              personID: BigInt.zero,
              gemID: 'demo2',
              chestID: 'demo',
            ),
          ],
          chestID: 'demo',
          shareToken: null,
          people: _people,
        ),
      ];

  /// The gem tokens.
  List<String> get gemTokens => gems.map((gem) => gem.id).toList()..shuffle();

  /// Fakes fetching a gem.
  Future<void> emitGemWithToken(String token) async {
    // Issue: The animated gem will not change without the fake delay.
    emit(CDemoState.inProgress(gemID: token));
    await Future.delayed(const Duration(milliseconds: 50));
    emit(CDemoState.completed(gem: gems.firstWhere((gem) => gem.id == token)));
  }
}
