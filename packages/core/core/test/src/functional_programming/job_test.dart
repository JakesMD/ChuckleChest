import 'package:ccore/ccore.dart';
import 'package:cpub_dev/flutter_test.dart';
import 'package:cpub_dev/test_beautifier.dart';

void main() {
  group('BJob tests', () {
    group('run', () {
      test(
        requirement(
          Given: 'a successful job',
          When: 'the job is run',
          Then: 'returns a success',
        ),
        procedure(() async {
          final job = CJob(run: () => CSuccess(1));

          final result = await job.run();

          cExpectSuccess(result, 1);
        }),
      );

      test(
        requirement(
          Given: 'a failing job',
          When: 'the job is run',
          Then: 'returns a failure',
        ),
        procedure(() async {
          final job = CJob(run: () => CFailure('error'));

          final result = await job.run();

          cExpectFailure(result, 'error');
        }),
      );
    });

    group('attempt', () {
      test(
        requirement(
          Given: 'a successful job',
          When: 'the job is run',
          Then: 'returns a success',
        ),
        procedure(() async {
          final job = CJob.attempt(
            run: () => 1,
            onError: (error) => 'error',
          );

          final result = await job.run();

          cExpectSuccess(result, 1);
        }),
      );

      test(
        requirement(
          Given: 'a failing job',
          When: 'the job is run',
          Then: 'returns a failure',
        ),
        procedure(() async {
          final job = CJob.attempt(
            run: () => throw Exception(),
            onError: (error) => 'error',
          );

          final result = await job.run();

          cExpectFailure(result, 'error');
        }),
      );
    });

    group('then', () {
      test(
        requirement(
          Given: 'a successful job chained with another job',
          When: 'the job is run',
          Then: 'returns second success',
        ),
        procedure(() async {
          final job = CJob.attempt(
            run: () => 1,
            onError: (error) => 'error1',
          ).then(run: (value) => value + 1);

          final result = await job.run();

          cExpectSuccess(result, 2);
        }),
      );

      test(
        requirement(
          Given: 'a failing job chained with another job',
          When: 'the job is run',
          Then: 'returns the failure',
        ),
        procedure(() async {
          final job = CJob.attempt(
            run: () => throw Exception(),
            onError: (error) => 'error1',
          ).then(run: (value) => value);

          final result = await job.run();

          cExpectFailure(result, 'error1');
        }),
      );
    });

    group('thenAttempt', () {
      test(
        requirement(
          Given: 'a successful job chained with another successful job',
          When: 'the job is run',
          Then: 'returns second success',
        ),
        procedure(() async {
          final job = CJob.attempt(
            run: () => 1,
            onError: (error) => 'error1',
          ).thenAttempt(
            run: (value) => value + 1,
            onError: (error) => 'error2',
          );

          final result = await job.run();

          cExpectSuccess(result, 2);
        }),
      );

      test(
        requirement(
          Given: 'a successful job chained with a failing job',
          When: 'the job is run',
          Then: 'returns the second failure',
        ),
        procedure(() async {
          final job = CJob.attempt(
            run: () => 1,
            onError: (error) => 'error1',
          ).thenAttempt(
            run: (value) => throw Exception(),
            onError: (error) => 'error2',
          );

          final result = await job.run();

          cExpectFailure(result, 'error2');
        }),
      );

      test(
        requirement(
          Given: 'a failing job chained with a successful job',
          When: 'the job is run',
          Then: 'returns the first failure',
        ),
        procedure(() async {
          final job = CJob.attempt(
            run: () => throw Exception(),
            onError: (error) => 'error1',
          ).thenAttempt(
            run: (value) => 1,
            onError: (error) => 'error2',
          );

          final result = await job.run();

          cExpectFailure(result, 'error1');
        }),
      );

      test(
        requirement(
          Given: 'a failing job chained with another failing job',
          When: 'the job is run',
          Then: 'returns the first failure',
        ),
        procedure(() async {
          final job = CJob.attempt(
            run: () => throw Exception(),
            onError: (error) => 'error1',
          ).thenAttempt(
            run: (value) => throw Exception(),
            onError: (error) => 'error2',
          );

          final result = await job.run();

          cExpectFailure(result, 'error1');
        }),
      );
    });

    group('thenEvaluate', () {
      test(
        requirement(
          Given: 'a successful job',
          When: 'the job is evaluated',
          Then: 'returns the second success',
        ),
        procedure(() async {
          CJob.attempt(run: () => 1, onError: (error) => 'error1')
              .thenEvaluate(
                onFailure: (error) => fail('Should not be called'),
                onSuccess: (value) => expect(value, 1),
              )
              .run();
        }),
      );

      test(
        requirement(
          Given: 'a failing job',
          When: 'the job is evaluated',
          Then: 'returns the second failure',
        ),
        procedure(() async {
          CJob.attempt(
            run: () => throw Exception(),
            onError: (error) => 'error1',
          )
              .thenEvaluate(
                onFailure: (error) => expect(error, 'error1'),
                onSuccess: (value) => fail('Should not be called'),
              )
              .run();
        }),
      );
    });

    group('thenEvaluateOnFailure', () {
      test(
        requirement(
          Given: 'a successful job',
          When: 'the job is evaluated',
          Then: 'returns the first success',
        ),
        procedure(() async {
          final job = CJob.attempt(
            run: () => 1,
            onError: (error) => 'error1',
          ).thenEvaluateOnFailure((error) => fail('Should not be called'));

          final result = await job.run();

          cExpectSuccess(result, 1);
        }),
      );

      test(
        requirement(
          Given: 'a failing job',
          When: 'the job is evaluated',
          Then: 'returns the second failure',
        ),
        procedure(() async {
          final job = CJob.attempt(
            run: () => throw Exception(),
            onError: (error) => 'error1',
          ).thenEvaluateOnFailure((error) => 'error2');

          final result = await job.run();

          cExpectFailure(result, 'error2');
        }),
      );
    });

    group('cFakeSuccessJob', () {
      test(
        requirement(
          Given: 'a fake success job',
          When: 'the job is run',
          Then: 'returns the success',
        ),
        procedure(() async {
          final job = cFakeSuccessJob(1);

          final result = await job.run();

          cExpectSuccess(result, 1);
        }),
      );
    });

    group('cFakeFailureJob', () {
      test(
        requirement(
          Given: 'a fake failure job',
          When: 'the job is run',
          Then: 'returns the failure',
        ),
        procedure(() async {
          final job = cFakeFailureJob(1);

          final result = await job.run();

          cExpectFailure(result, 1);
        }),
      );
    });
  });
}
