import 'package:ccore/ccore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_beautifier/test_beautifier.dart';

void main() {
  group('CDateTimeExtension tests', () {
    test(
      requirement(
        given: 'date-time of birthday',
        whenever: 'fetch age before birthday',
        then: 'returns age',
      ),
      procedure(() {
        final result = DateTime(2003, 10, 4).cAge(DateTime(2024, 10, 3));
        expect(result, 20);
      }),
    );

    test(
      requirement(
        given: 'date-time of birthday',
        whenever: 'fetch age after birthday',
        then: 'returns age',
      ),
      procedure(() {
        final result = DateTime(2003, 10, 4).cAge(DateTime(2024, 10, 5));
        expect(result, 21);
      }),
    );

    test(
      requirement(
        given: 'date-time of birthday',
        whenever: 'fetch age on birthday',
        then: 'returns age',
      ),
      procedure(() {
        final result = DateTime(2003, 10, 4).cAge(DateTime(2024, 10, 4));
        expect(result, 21);
      }),
    );
  });
}
