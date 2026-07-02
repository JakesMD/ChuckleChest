import 'package:bobs_jobs/bobs_jobs.dart';
import 'package:cgem_repository/cgem_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_beautifier/test_beautifier.dart';

const _chestID = 'chest-1';
const _gemID = 'gem-1';

CGem _fakeGem({String? shareToken}) => CGem(
  id: _gemID,
  number: 1,
  occurredAt: DateTime(2024),
  lines: const [],
  chestID: _chestID,
  shareToken: shareToken,
);

void main() {
  group('CGem', () {
    group('copyWith', () {
      test(
        requirement(
          given: 'gem',
          whenever: 'copyWith called with new occurredAt',
          then: 'returns gem with updated occurredAt',
        ),
        () {
          final newDate = DateTime(2025);
          final result = _fakeGem().copyWith(occurredAt: newDate);
          expect(result.occurredAt, newDate);
          expect(result.id, _gemID);
        },
      );

      test(
        requirement(
          given: 'gem without share token',
          whenever: 'copyWith called with present share token',
          then: 'returns gem with new share token',
        ),
        () {
          final result = _fakeGem().copyWith(
            shareToken: bobsPresent('new-token'),
          );
          expect(result.shareToken, 'new-token');
        },
      );

      test(
        requirement(
          given: 'gem with share token',
          whenever: 'copyWith called with absent share token',
          then: 'keeps existing share token',
        ),
        () {
          final result = _fakeGem(shareToken: 'old-token').copyWith(
            shareToken: bobsAbsent(),
          );
          expect(result.shareToken, 'old-token');
        },
      );

      test(
        requirement(
          given: 'gem with share token',
          whenever: 'copyWith called with no share token argument',
          then: 'keeps existing share token',
        ),
        () {
          final result = _fakeGem(shareToken: 'existing-token').copyWith();
          expect(result.shareToken, 'existing-token');
        },
      );
    });
  });
}
