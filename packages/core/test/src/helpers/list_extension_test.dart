import 'package:ccore/src/helpers/list_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_beautifier/test_beautifier.dart';

void main() {
  group('CListExtension tests', () {
    test(
      requirement(
        given: 'a list of numbers containing a specific number',
        whenever: 'cFirstWhereOrNull for that specific number is called',
        then: 'the number is returned',
      ),
      procedure(() {
        final numbers = [1, 2, 3, 4, 5];
        final number = numbers.cFirstWhereOrNull((element) => element == 3);
        expect(number, 3);
      }),
    );
    test(
      requirement(
        given: 'a list of numbers',
        whenever: 'cFirstWhereOrNull for a missing number is called',
        then: 'null is returned',
      ),
      procedure(() {
        final numbers = [1, 2, 4, 5];
        final number = numbers.cFirstWhereOrNull((element) => element == 3);
        expect(number, isNull);
      }),
    );
  });
}
