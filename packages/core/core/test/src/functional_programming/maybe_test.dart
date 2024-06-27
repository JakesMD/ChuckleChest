import 'package:ccore/ccore.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/test_beautifier.dart';

void main() {
  group('CMaybe tests', () {
    group('evaluate', () {
      test(
        requirement(
          Given: 'a present value',
          When: 'the maybe is evaluated',
          Then: 'the [onPresent] function is called',
        ),
        procedure(() {
          final result = cPresent(1).evaluate(
            onAbsent: () => fail('Should not be called'),
            onPresent: (value) => value,
          );

          expect(result, 1);
        }),
      );

      test(
        requirement(
          Given: 'a absent value',
          When: 'the maybe is evaluated',
          Then: 'the [onAbsent] function is called',
        ),
        procedure(() {
          final result = CAbsent().evaluate(
            onAbsent: () => 'absent',
            onPresent: (_) => fail('Should not be called'),
          );

          expect(result, 'absent');
        }),
      );
    });

    group('deriveOnPresent', () {
      test(
        requirement(
          Given: 'a present value',
          When: 'the maybe is derived',
          Then: 'returns a new maybe with the new value',
        ),
        procedure(() {
          final result = cPresent(1).deriveOnPresent((value) => value + 1);

          expect(result, cPresent(2));
        }),
      );

      test(
        requirement(
          Given: 'a absent value',
          When: 'the maybe is derived',
          Then: 'returns an absent maybe',
        ),
        procedure(() {
          final result = CAbsent<int>().deriveOnPresent((value) => value + 1);

          expect(result, cAbsent());
        }),
      );
    });

    group('cPresent', () {
      test(
        requirement(
          Given: 'a present value',
          When: 'a present is created',
          Then: 'returns a [CPresent] instance with the value',
        ),
        procedure(() {
          final present = cPresent(1);

          expect(present, CPresent(1));
          expect((present as CPresent).value, 1);
        }),
      );
    });

    group('cAbsent', () {
      test(
        requirement(
          When: 'an absent is created',
          Then: 'returns a [CAbsent] instance',
        ),
        procedure(() {
          final absent = cAbsent<int>();

          expect(absent, isA<CAbsent<int>>());
        }),
      );

      test(
        requirement(
          Given: 'absent with type and another absent without type',
          When: 'both are compared',
          Then: 'both are equal',
        ),
        procedure(() {
          late CMaybe<int> maybe;

          maybe = cAbsent<int>();

          expect(maybe, cAbsent());
        }),
      );

      test(
        requirement(
          When: 'hashcode',
          Then: 'does not fail',
        ),
        procedure(() {
          expect(cAbsent().hashCode, isA<int>());
        }),
      );
    });
  });
}
