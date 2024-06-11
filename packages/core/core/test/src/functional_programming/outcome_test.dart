import 'package:ccore/ccore.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/test_beautifier.dart';

void main() {
  group('COutcome Tests', () {
    group('evaluate', () {
      test(
        requirement(
          Given: 'a successful outcome',
          When: 'the outcome is evaluated',
          Then: 'the success function is called',
        ),
        procedure(() {
          final result = CSuccess(1).evaluate(
            onFailure: (_) => fail('Should not be called'),
            onSuccess: (value) => value,
          );

          expect(result, 1);
        }),
      );

      test(
        requirement(
          Given: 'a failed outcome',
          When: 'the outcome is evaluated',
          Then: 'the failure function is called',
        ),
        procedure(() {
          final result = CFailure('error').evaluate(
            onFailure: (error) => error,
            onSuccess: (_) => fail('Should not be called'),
          );

          expect(result, 'error');
        }),
      );
    });

    group('cSuccess', () {
      test(
        requirement(
          Given: 'a value',
          When: 'a success outcome is created',
          Then: 'the value is stored',
        ),
        procedure(() {
          final outcome = cSuccess(1);

          expect(outcome.value, 1);
        }),
      );
    });

    group('cFailure', () {
      test(
        requirement(
          Given: 'an error',
          When: 'a failure outcome is created',
          Then: 'the error is stored',
        ),
        procedure(() {
          final outcome = cFailure('error');

          expect(outcome.value, 'error');
        }),
      );
    });
  });
}
