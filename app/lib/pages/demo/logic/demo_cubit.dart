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
      dateOfBirth: DateTime(2020, 2, 2),
      avatarURLs: [
        const CAvatarURL(
          url:
              'https://mgopsyysiuhacmfpxpdd.supabase.co/storage/v1/object/sign/demo/girl-2.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJkZW1vL2dpcmwtMi5wbmciLCJpYXQiOjE3NDU5NTA3OTksImV4cCI6NDg5OTU1MDc5OX0.LLnRB8vARDCRmFlUJz8boHXdcR4PrFQeWNLECpPPUlA',
          year: 2022,
        ),
        const CAvatarURL(
          url:
              'https://mgopsyysiuhacmfpxpdd.supabase.co/storage/v1/object/sign/demo/girl-3.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJkZW1vL2dpcmwtMy5wbmciLCJpYXQiOjE3NDU5NTA5NTgsImV4cCI6NDg5OTU1MDk1OH0.i7pgda7kMdF2IDGHjaM4VSn_8gh_xsXxMrsWpNFrV3M',
          year: 2023,
        ),
        const CAvatarURL(
          url:
              'https://mgopsyysiuhacmfpxpdd.supabase.co/storage/v1/object/sign/demo/girl-4.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJkZW1vL2dpcmwtNC5wbmciLCJpYXQiOjE3NDU5NTA4MzMsImV4cCI6NDg5OTU1MDgzM30.AydG_eHfJfva6bYD1m_Rx5OKuduT8JbtuIR5eBp2_zc',
          year: 2024,
        ),
        const CAvatarURL(
          url:
              'https://mgopsyysiuhacmfpxpdd.supabase.co/storage/v1/object/sign/demo/girl-5.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJkZW1vL2dpcmwtNS5wbmciLCJpYXQiOjE3NDU5NTEwMDUsImV4cCI6NDg5OTU1MTAwNX0.WLl5oM3Wkkavfota2OciMLs3SGMM_-OInXJ2q-_448g',
          year: 2025,
        ),
      ],
      chestID: 'demo',
    ),
    CPerson(
      id: BigInt.one,
      nickname: 'Mum',
      dateOfBirth: DateTime(1993, 5, 5),
      avatarURLs: [
        const CAvatarURL(
          url:
              'https://mgopsyysiuhacmfpxpdd.supabase.co/storage/v1/object/sign/demo/woman-29.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJkZW1vL3dvbWFuLTI5LnBuZyIsImlhdCI6MTc0NTk1MDg3MSwiZXhwIjo0ODk5NTUwODcxfQ.Ka4KTyvlJQcpxWq4_AHKQpCmuG93zunDru-7bBVsQQs',
          year: 2022,
        ),
        const CAvatarURL(
          url:
              'https://mgopsyysiuhacmfpxpdd.supabase.co/storage/v1/object/sign/demo/woman-30.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJkZW1vL3dvbWFuLTMwLnBuZyIsImlhdCI6MTc0NTk1MTEyNSwiZXhwIjo0ODk5NTUxMTI1fQ.loN9CC5kK1ZhiAbEKhGxAsNC3dBDU3LmhXFJsygg06w',
          year: 2023,
        ),
        const CAvatarURL(
          url:
              'https://mgopsyysiuhacmfpxpdd.supabase.co/storage/v1/object/sign/demo/woman-31.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJkZW1vL3dvbWFuLTMxLnBuZyIsImlhdCI6MTc0NTk1MDg5MywiZXhwIjo0ODk5NTUwODkzfQ.RqLC_VDDYJbirAWS6If86egs7LSFL3AjdqmTwzbTkJE',
          year: 2024,
        ),
        const CAvatarURL(
          url:
              'https://mgopsyysiuhacmfpxpdd.supabase.co/storage/v1/object/sign/demo/woman-32.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJkZW1vL3dvbWFuLTMyLnBuZyIsImlhdCI6MTc0NTk1MTE0MiwiZXhwIjo0ODk5NTUxMTQyfQ.GjEjc1ZQEpQ7Hpau4siH8CD1NXRj5MmBUeX7b3w8J9E',
          year: 2025,
        ),
      ],
      chestID: 'demo',
    ),
  ];

  /// The demo gems.
  List<CSharedGem> get gems => [
        CSharedGem(
          id: 'demo4',
          number: 202,
          occurredAt: DateTime(2022, 10, 14),
          lines: [
            CLine(
              id: BigInt.zero,
              text: 'Do you love Mummy, Amy?',
              personID: BigInt.one,
              gemID: 'demo4',
              chestID: 'demo',
            ),
            CLine(
              id: BigInt.one,
              text: 'Amy looks down at her socks.',
              personID: null,
              gemID: 'demo4',
              chestID: 'demo',
            ),
            CLine(
              id: BigInt.two,
              text: 'No. Got my "I love Daddy" socks on today.',
              personID: BigInt.zero,
              gemID: 'demo4',
              chestID: 'demo',
            ),
          ],
          chestID: 'demo',
          shareToken: null,
          people: _people,
        ),
        CSharedGem(
          id: 'demo5',
          number: 426,
          occurredAt: DateTime(2024, 12, 22),
          lines: [
            CLine(
              id: BigInt.zero,
              text: 'Amy announcing the next song at the nativity:',
              personID: null,
              gemID: 'demo5',
              chestID: 'demo',
            ),
            CLine(
              id: BigInt.one,
              text: 'A whale in a manger!',
              personID: BigInt.zero,
              gemID: 'demo5',
              chestID: 'demo',
            ),
          ],
          chestID: 'demo',
          shareToken: null,
          people: _people,
        ),
        CSharedGem(
          id: 'demo6',
          number: 457,
          occurredAt: DateTime(2025, 3, 15),
          lines: [
            CLine(
              id: BigInt.zero,
              text:
                  '''Mummy, how do you know that it's a baby? You might have just eaten too much.''',
              personID: BigInt.zero,
              gemID: 'demo6',
              chestID: 'demo',
            ),
          ],
          chestID: 'demo',
          shareToken: null,
          people: _people,
        ),
        CSharedGem(
          id: 'demo1',
          number: 156,
          occurredAt: DateTime(2022, 8, 10),
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
          number: 157,
          occurredAt: DateTime(2022, 8, 10),
          lines: [
            CLine(
              id: BigInt.zero,
              text: "Luke's just a baby, isn't he?",
              personID: BigInt.zero,
              gemID: 'demo2',
              chestID: 'demo',
            ),
            CLine(
              id: BigInt.one,
              text: "Yes, he's not a big girl like you.",
              personID: BigInt.one,
              gemID: 'demo2',
              chestID: 'demo',
            ),
            CLine(
              id: BigInt.two,
              text: "No, he can't pick his nose, can he?",
              personID: BigInt.zero,
              gemID: 'demo2',
              chestID: 'demo',
            ),
          ],
          chestID: 'demo',
          shareToken: null,
          people: _people,
        ),
        CSharedGem(
          id: 'demo3',
          number: 183,
          occurredAt: DateTime(2022, 11, 18),
          lines: [
            CLine(
              id: BigInt.zero,
              text: "We arrive at Gran's house.",
              personID: null,
              gemID: 'demo3',
              chestID: 'demo',
            ),
            CLine(
              id: BigInt.one,
              text:
                  'Amy runs straight to the kitchen and sits up at the table.',
              personID: null,
              gemID: 'demo3',
              chestID: 'demo',
            ),
            CLine(
              id: BigInt.two,
              text: 'Cake please!',
              personID: BigInt.zero,
              gemID: 'demo3',
              chestID: 'demo',
            ),
          ],
          chestID: 'demo',
          shareToken: null,
          people: _people,
        ),
        CSharedGem(
          id: 'demo5',
          number: 426,
          occurredAt: DateTime(2024, 12, 22),
          lines: [
            CLine(
              id: BigInt.zero,
              text: 'Amy announcing the next song at the nativity:',
              personID: null,
              gemID: 'demo5',
              chestID: 'demo',
            ),
            CLine(
              id: BigInt.one,
              text: 'A whale in a manger!',
              personID: BigInt.zero,
              gemID: 'demo5',
              chestID: 'demo',
            ),
          ],
          chestID: 'demo',
          shareToken: null,
          people: _people,
        ),
      ];

  /// The gem tokens.
  List<String> get gemTokens =>
      gems.map((gem) => gem.id).toList(); // ..shuffle();

  /// Fakes fetching a gem.
  Future<void> emitGemWithToken(String token) async {
    // Issue: The animated gem will not change without the fake delay.
    emit(CDemoState.inProgress(gemID: token));
    await Future.delayed(const Duration(milliseconds: 50));
    emit(CDemoState.completed(gem: gems.firstWhere((gem) => gem.id == token)));
  }
}
