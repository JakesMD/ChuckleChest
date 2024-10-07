import 'package:cgem_repository/cgem_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_beautifier/test_beautifier.dart';

void main() {
  group('CGem', () {
    final gem = CGem(
      id: 'adsdasd',
      number: 3,
      occurredAt: DateTime(2024),
      lines: [
        CLine(
          id: BigInt.zero,
          text: 'sdjfsdf',
          personID: BigInt.two,
          gemID: 'adsdasd',
          chestID: 'asdf',
        ),
      ],
      chestID: 'asdf',
    );

    group('copyWith', () {
      test(
        requirement(
          Given: 'a gem',
          When: 'copyWith is called with new values',
          Then: 'a new gem is returned with the new values',
        ),
        procedure(() {
          final newGem = gem.copyWith(
            occurredAt: DateTime(2025),
          );

          expect(newGem.id, gem.id);
          expect(newGem.number, gem.number);
          expect(newGem.occurredAt, DateTime(2025));
        }),
      );

      test(
        requirement(
          Given: 'a gem',
          When: 'copyWith is called without new values',
          Then: 'the same gem is returned',
        ),
        procedure(() {
          final newGem = gem.copyWith();

          expect(newGem, gem);
        }),
      );
    });
  });
}
