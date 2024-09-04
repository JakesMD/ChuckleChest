import 'package:cgem_repository/cgem_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_beautifier/test_beautifier.dart';

void main() {
  group('CLine', () {
    group('copyWith', () {
      final line = CLine(
        id: BigInt.zero,
        text: 'sdjfsdf',
        personID: BigInt.two,
        gemID: 'adsdasd',
        chestID: 'asdf',
      );
      test(
        requirement(
          Given: 'a line',
          When: 'copyWith is called with new values',
          Then: 'a new line is returned with the new values',
        ),
        procedure(() {
          final newLine = line.copyWith(
            text: 'text',
            personID: BigInt.one,
          );

          expect(newLine.id, line.id);
          expect(newLine.text, 'text');
          expect(newLine.personID, BigInt.one);
        }),
      );

      test(
        requirement(
          Given: 'a line',
          When: 'copyWith is called without new values',
          Then: 'the same line is returned',
        ),
        procedure(() {
          final newLine = line.copyWith();

          expect(newLine, line);
        }),
      );
    });

    group('isQuote', () {
      test(
        requirement(
          Given: 'a line with a personID',
          When: 'isQuote is called',
          Then: 'true is returned',
        ),
        procedure(() {
          final line = CLine(
            id: BigInt.zero,
            text: 'sdjfsdf',
            personID: BigInt.two,
            gemID: 'adsdasd',
            chestID: 'asdf',
          );

          expect(line.isQuote, isTrue);
        }),
      );

      test(
        requirement(
          Given: 'a line without a personID',
          When: 'isQuote is called',
          Then: 'false is returned',
        ),
        procedure(() {
          final line = CLine(
            id: BigInt.zero,
            text: 'sdjfsdf',
            personID: null,
            gemID: 'adsdasd',
            chestID: 'asdf',
          );

          expect(line.isQuote, isFalse);
        }),
      );
    });
  });
}
